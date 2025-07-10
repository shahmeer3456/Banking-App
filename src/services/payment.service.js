const config = require('../config/config');
const Transaction = require('../models/transaction.model');
const Account = require('../models/account.model');
const notificationService = require('./notification.service');

class PaymentService {
  constructor() {
    this.processingFee = parseFloat(process.env.PROCESSING_FEE_PERCENTAGE) || 2.5;
    this.enableInternational = process.env.ENABLE_INTERNATIONAL_TRANSFERS === 'true';
    this.transferLimitLocal = parseFloat(process.env.TRANSFER_LIMIT_LOCAL) || 50000;
    this.transferLimitInternational = parseFloat(process.env.TRANSFER_LIMIT_INTERNATIONAL) || 10000;
    this.minimumBalance = parseFloat(process.env.MINIMUM_BALANCE_REQUIRED) || 1000;
  }

  calculateProcessingFee(amount, isInternational = false) {
    const feePercentage = isInternational ? this.processingFee * 2 : this.processingFee;
    return (amount * feePercentage) / 100;
  }

  async validateTransaction(fromAccount, amount, isInternational = false) {
    // Check if account exists and is active
    if (!fromAccount || fromAccount.status !== 'active') {
      throw new Error('Invalid or inactive account');
    }

    // Check transaction limits
    const limit = isInternational ? this.transferLimitInternational : this.transferLimitLocal;
    if (amount > limit) {
      throw new Error(`Transaction amount exceeds ${isInternational ? 'international' : 'local'} transfer limit`);
    }

    // Check if international transfers are enabled
    if (isInternational && !this.enableInternational) {
      throw new Error('International transfers are not enabled');
    }

    // Calculate total amount including fees
    const fee = this.calculateProcessingFee(amount, isInternational);
    const totalAmount = amount + fee;

    // Check if account has sufficient balance
    if (fromAccount.balance - totalAmount < this.minimumBalance) {
      throw new Error('Insufficient balance including minimum balance requirement');
    }

    return { fee, totalAmount };
  }

  async processLocalTransfer(fromAccountId, toAccountId, amount, description) {
    try {
      const fromAccount = await Account.findById(fromAccountId);
      const toAccount = await Account.findById(toAccountId);

      // Validate accounts and amount
      const { fee, totalAmount } = await this.validateTransaction(fromAccount, amount);

      // Create transaction record
      const transaction = new Transaction({
        fromAccount: fromAccountId,
        toAccount: toAccountId,
        amount: amount,
        fee: fee,
        type: 'transfer',
        description: description,
        status: 'pending'
      });

      // Update account balances
      fromAccount.balance -= totalAmount;
      toAccount.balance += amount;

      // Save all changes in a transaction
      await Promise.all([
        fromAccount.save(),
        toAccount.save(),
        transaction.save()
      ]);

      // Update transaction status
      transaction.status = 'completed';
      await transaction.save();

      // Send notifications
      await this._sendTransactionNotifications(transaction, fromAccount, toAccount);

      return {
        transactionId: transaction._id,
        amount: amount,
        fee: fee,
        total: totalAmount,
        status: 'completed'
      };
    } catch (error) {
      throw new Error(`Transfer failed: ${error.message}`);
    }
  }

  async processInternationalTransfer(fromAccountId, recipientDetails, amount, description) {
    try {
      const fromAccount = await Account.findById(fromAccountId);

      // Validate account and amount for international transfer
      const { fee, totalAmount } = await this.validateTransaction(fromAccount, amount, true);

      // Create transaction record
      const transaction = new Transaction({
        fromAccount: fromAccountId,
        recipientDetails: recipientDetails,
        amount: amount,
        fee: fee,
        type: 'international_transfer',
        description: description,
        status: 'pending'
      });

      // Update sender's account balance
      fromAccount.balance -= totalAmount;

      // Save changes
      await Promise.all([
        fromAccount.save(),
        transaction.save()
      ]);

      // Update transaction status
      transaction.status = 'completed';
      await transaction.save();

      // Send notification to sender
      await this._sendTransactionNotifications(transaction, fromAccount);

      return {
        transactionId: transaction._id,
        amount: amount,
        fee: fee,
        total: totalAmount,
        status: 'completed'
      };
    } catch (error) {
      throw new Error(`International transfer failed: ${error.message}`);
    }
  }

  async processCardPayment(cardId, amount, merchantDetails) {
    try {
      const card = await Card.findById(cardId).populate('account');
      if (!card || card.status !== 'active') {
        throw new Error('Invalid or inactive card');
      }

      const { fee, totalAmount } = await this.validateTransaction(card.account, amount);

      // Create transaction record
      const transaction = new Transaction({
        fromAccount: card.account._id,
        cardUsed: cardId,
        merchantDetails: merchantDetails,
        amount: amount,
        fee: fee,
        type: 'card_payment',
        status: 'pending'
      });

      // Update account balance
      card.account.balance -= totalAmount;

      // Save changes
      await Promise.all([
        card.account.save(),
        transaction.save()
      ]);

      // Update transaction status
      transaction.status = 'completed';
      await transaction.save();

      // Send notification
      await this._sendTransactionNotifications(transaction, card.account);

      return {
        transactionId: transaction._id,
        amount: amount,
        fee: fee,
        total: totalAmount,
        status: 'completed'
      };
    } catch (error) {
      throw new Error(`Card payment failed: ${error.message}`);
    }
  }

  async _sendTransactionNotifications(transaction, fromAccount, toAccount = null) {
    // Notify sender
    await notificationService.sendNotification(fromAccount.user, 'transaction', {
      type: transaction.type,
      amount: transaction.amount,
      fee: transaction.fee,
      status: transaction.status,
      email: fromAccount.email
    });

    // Notify recipient for local transfers
    if (toAccount) {
      await notificationService.sendNotification(toAccount.user, 'transaction', {
        type: 'received',
        amount: transaction.amount,
        status: transaction.status,
        email: toAccount.email
      });
    }
  }

  // Additional helper methods
  async getDailyTransactionTotal(accountId) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    return await Transaction.aggregate([
      {
        $match: {
          fromAccount: accountId,
          createdAt: { $gte: today },
          status: 'completed'
        }
      },
      {
        $group: {
          _id: null,
          total: { $sum: '$amount' }
        }
      }
    ]);
  }

  async getTransactionHistory(accountId, filters = {}) {
    const query = { 
      $or: [
        { fromAccount: accountId },
        { toAccount: accountId }
      ]
    };

    if (filters.startDate) {
      query.createdAt = { $gte: new Date(filters.startDate) };
    }
    if (filters.endDate) {
      query.createdAt = { ...query.createdAt, $lte: new Date(filters.endDate) };
    }
    if (filters.type) {
      query.type = filters.type;
    }
    if (filters.status) {
      query.status = filters.status;
    }

    return await Transaction.find(query)
      .sort({ createdAt: -1 })
      .populate('fromAccount toAccount', 'name accountNumber');
  }
}

module.exports = new PaymentService(); 