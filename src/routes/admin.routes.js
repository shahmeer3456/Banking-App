const express = require('express');
const router = express.Router();
const Account = require('../models/account.model');
const Transaction = require('../models/transaction.model');
const authMiddleware = require('../middleware/auth.middleware');
const Terms = require('../models/terms.model'); // Added Terms model import

// Admin authentication middleware
router.use(authMiddleware.adminAuth);

// Get all accounts
router.get('/accounts', async (req, res) => {
    try {
        const accounts = await Account.find().populate('user');
        res.json(accounts);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Cash deposit
router.post('/deposit', async (req, res) => {
    try {
        const { accountId, amount, notes } = req.body;

        if (!accountId || !amount || amount <= 0) {
            return res.status(400).json({ message: 'Invalid deposit details' });
        }

        const account = await Account.findById(accountId);
        if (!account) {
            return res.status(404).json({ message: 'Account not found' });
        }

        // Create transaction record
        const transaction = new Transaction({
            account: accountId,
            type: 'deposit',
            amount: amount,
            method: 'cash',
            status: 'completed',
            notes: notes || 'Cash deposit by admin',
            performedBy: req.admin._id
        });

        // Update account balance
        account.balance += amount;
        
        await Promise.all([
            transaction.save(),
            account.save()
        ]);

        res.json({
            message: 'Deposit successful',
            transaction,
            newBalance: account.balance
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Cheque withdrawal
router.post('/withdraw', async (req, res) => {
    try {
        const { accountId, amount, chequeNumber, notes } = req.body;

        if (!accountId || !amount || amount <= 0 || !chequeNumber) {
            return res.status(400).json({ message: 'Invalid withdrawal details' });
        }

        const account = await Account.findById(accountId);
        if (!account) {
            return res.status(404).json({ message: 'Account not found' });
        }

        // Check if withdrawal is allowed
        if (!account.canWithdraw(amount)) {
            return res.status(400).json({ 
                message: 'Insufficient balance or below minimum balance requirement'
            });
        }

        // Create transaction record
        const transaction = new Transaction({
            account: accountId,
            type: 'withdrawal',
            amount: amount,
            method: 'cheque',
            chequeNumber: chequeNumber,
            status: 'completed',
            notes: notes || 'Cheque withdrawal by admin',
            performedBy: req.admin._id
        });

        // Update account balance
        account.balance -= amount;
        
        await Promise.all([
            transaction.save(),
            account.save()
        ]);

        res.json({
            message: 'Withdrawal successful',
            transaction,
            newBalance: account.balance
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Create new account
router.post('/accounts', async (req, res) => {
    try {
        const { userId, accountType } = req.body;

        const account = new Account({
            user: userId,
            accountType: accountType
        });

        await account.save();

        res.status(201).json({
            message: 'Account created successfully',
            account
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Get account type details
router.get('/account-types', (req, res) => {
    try {
        const accountTypes = Account.getAccountTypeDetails();
        res.json(accountTypes);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Update account status
router.patch('/accounts/:id/status', async (req, res) => {
    try {
        const { status } = req.body;
        const account = await Account.findById(req.params.id);
        
        if (!account) {
            return res.status(404).json({ message: 'Account not found' });
        }

        account.status = status;
        await account.save();

        res.json({
            message: 'Account status updated successfully',
            account
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Get terms and conditions for an account type
router.get('/terms/:accountType', async (req, res) => {
    try {
        const terms = await Terms.getCurrentTerms(req.params.accountType);
        if (!terms) {
            // If no custom terms exist, return default terms
            const defaultTerms = Terms.getDefaultTerms(req.params.accountType);
            return res.json(defaultTerms);
        }
        res.json(terms);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Create new terms and conditions
router.post('/terms', async (req, res) => {
    try {
        const { accountType, version, generalTerms, accountSpecificTerms, feesAndCharges, benefitsAndPrivileges } = req.body;

        // Deactivate current active terms for this account type
        await Terms.updateMany(
            { accountType, isActive: true },
            { isActive: false }
        );

        // Create new terms
        const terms = new Terms({
            accountType,
            version,
            generalTerms,
            accountSpecificTerms,
            feesAndCharges,
            benefitsAndPrivileges
        });

        await terms.save();
        res.status(201).json(terms);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Update terms and conditions
router.put('/terms/:id', async (req, res) => {
    try {
        const terms = await Terms.findById(req.params.id);
        if (!terms) {
            return res.status(404).json({ message: 'Terms not found' });
        }

        Object.assign(terms, req.body);
        await terms.save();
        res.json(terms);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router; 