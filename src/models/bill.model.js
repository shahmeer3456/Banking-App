const mongoose = require('mongoose');

const billSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    billType: {
        type: String,
        enum: ['electricity', 'gas', 'internet', 'mobile', 'water', 'other'],
        required: true
    },
    provider: {
        type: String,
        required: true
    },
    accountNumber: {
        type: String,
        required: true
    },
    amount: {
        type: Number,
        required: true
    },
    dueDate: {
        type: Date,
        required: true
    },
    status: {
        type: String,
        enum: ['pending', 'paid', 'overdue'],
        default: 'pending'
    },
    billNumber: {
        type: String,
        unique: true,
        required: true
    },
    paymentDate: {
        type: Date
    },
    transactionReference: {
        type: String
    }
}, {
    timestamps: true
});

// Generate bill number before saving
billSchema.pre('save', function(next) {
    if (this.isNew) {
        // Generate bill number: BILL + timestamp + random 4 digits
        this.billNumber = 'BILL' + Date.now() + Math.floor(Math.random() * 10000).toString().padStart(4, '0');
    }
    next();
});

const Bill = mongoose.model('Bill', billSchema);

module.exports = Bill; 