const express = require('express');
const router = express.Router();
const Transaction = require('../models/transaction.model');
const User = require('../models/user.model');
const Bill = require('../models/bill.model');
const authMiddleware = require('../middleware/auth.middleware');

// Transfer money
router.post('/transfer', authMiddleware, async (req, res) => {
    try {
        const { receiverAccountNumber, amount, description } = req.body;
        const sender = await User.findById(req.user._id);
        const receiver = await User.findOne({ accountNumber: receiverAccountNumber });

        if (!receiver) {
            return res.status(404).json({ message: 'Receiver account not found' });
        }

        if (sender.balance < amount) {
            return res.status(400).json({ message: 'Insufficient balance' });
        }

        // Create transaction
        const transaction = new Transaction({
            transactionType: 'transfer',
            amount,
            sender: sender._id,
            receiver: receiver._id,
            description,
            status: 'completed'
        });

        // Update balances
        sender.balance -= amount;
        receiver.balance += amount;

        await Promise.all([
            transaction.save(),
            sender.save(),
            receiver.save()
        ]);

        res.status(201).json({
            message: 'Transfer successful',
            transaction: {
                reference: transaction.reference,
                amount,
                receiverName: receiver.name,
                date: transaction.createdAt
            }
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Pay bill
router.post('/bill-payment', authMiddleware, async (req, res) => {
    try {
        const { billId } = req.body;
        const user = await User.findById(req.user._id);
        const bill = await Bill.findById(billId);

        if (!bill) {
            return res.status(404).json({ message: 'Bill not found' });
        }

        if (bill.status === 'paid') {
            return res.status(400).json({ message: 'Bill already paid' });
        }

        if (user.balance < bill.amount) {
            return res.status(400).json({ message: 'Insufficient balance' });
        }

        // Create transaction
        const transaction = new Transaction({
            transactionType: 'bill_payment',
            amount: bill.amount,
            sender: user._id,
            billDetails: {
                provider: bill.provider,
                customerNumber: bill.accountNumber,
                billType: bill.billType
            },
            status: 'completed'
        });

        // Update bill and user balance
        bill.status = 'paid';
        bill.paymentDate = new Date();
        bill.transactionReference = transaction.reference;
        user.balance -= bill.amount;

        await Promise.all([
            transaction.save(),
            bill.save(),
            user.save()
        ]);

        res.status(201).json({
            message: 'Bill payment successful',
            transaction: {
                reference: transaction.reference,
                amount: bill.amount,
                provider: bill.provider,
                date: transaction.createdAt
            }
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Get user's transactions
router.get('/history', authMiddleware, async (req, res) => {
    try {
        const transactions = await Transaction.find({
            $or: [
                { sender: req.user._id },
                { receiver: req.user._id }
            ]
        })
        .sort({ createdAt: -1 })
        .populate('sender', 'name accountNumber')
        .populate('receiver', 'name accountNumber');

        res.json(transactions);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Get transaction details
router.get('/:transactionId', authMiddleware, async (req, res) => {
    try {
        const transaction = await Transaction.findById(req.params.transactionId)
            .populate('sender', 'name accountNumber')
            .populate('receiver', 'name accountNumber');

        if (!transaction) {
            return res.status(404).json({ message: 'Transaction not found' });
        }

        // Check if user is involved in the transaction
        if (transaction.sender._id.toString() !== req.user._id.toString() &&
            transaction.receiver?._id.toString() !== req.user._id.toString()) {
            return res.status(403).json({ message: 'Access denied' });
        }

        res.json(transaction);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router; 