const mongoose = require('mongoose');

const savingsSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  accountNumber: {
    type: String,
    unique: true,
    required: true
  },
  accountType: {
    type: String,
    enum: ['savings', 'time_deposit'],
    required: true
  },
  balance: {
    type: Number,
    required: true,
    min: 0
  },
  interestRate: {
    type: Number,
    required: true
  },
  maturityDate: {
    type: Date,
    required: function() {
      return this.accountType === 'time_deposit';
    }
  },
  status: {
    type: String,
    enum: ['active', 'matured', 'closed'],
    default: 'active'
  },
  autoRenew: {
    type: Boolean,
    default: false
  },
  lastInterestPaid: {
    type: Date
  }
}, {
  timestamps: true
});

// Generate savings account number before saving
savingsSchema.pre('save', function(next) {
  if (this.isNew) {
    // Generate account number: 2222 (for savings) + random 12 digits
    this.accountNumber = '2222' + Math.floor(Math.random() * 1000000000000).toString().padStart(12, '0');
  }
  next();
});

const Savings = mongoose.model('Savings', savingsSchema);

module.exports = Savings; 