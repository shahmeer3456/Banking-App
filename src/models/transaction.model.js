const mongoose = require('mongoose');

const transactionSchema = new mongoose.Schema({
  transactionType: {
    type: String,
    enum: ['transfer', 'bill_payment', 'mobile_recharge', 'cheque_withdrawal', 'deposit'],
    required: true
  },
  amount: {
    type: Number,
    required: true
  },
  sender: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  receiver: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  status: {
    type: String,
    enum: ['pending', 'completed', 'failed'],
    default: 'pending'
  },
  description: {
    type: String
  },
  // For bill payments and mobile recharge
  billDetails: {
    provider: String,
    customerNumber: String,
    billType: {
      type: String,
      enum: ['electricity', 'gas', 'internet', 'mobile']
    }
  },
  // For cheque withdrawals
  chequeDetails: {
    chequeNumber: String,
    bankBranch: String
  },
  reference: {
    type: String,
    unique: true
  }
}, {
  timestamps: true
});

// Generate unique reference number
transactionSchema.pre('save', function(next) {
  if (this.isNew) {
    // Generate reference number: TR + timestamp + random 4 digits
    this.reference = 'TR' + Date.now() + Math.floor(Math.random() * 10000).toString().padStart(4, '0');
  }
  next();
});

const Transaction = mongoose.model('Transaction', transactionSchema);

module.exports = Transaction; 