const mongoose = require('mongoose');

const cardSchema = new mongoose.Schema({
  cardNumber: {
    type: String,
    unique: true,
    required: true
  },
  cardType: {
    type: String,
    enum: ['virtual', 'physical'],
    required: true
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  expiryDate: {
    type: Date,
    required: true
  },
  cvv: {
    type: String,
    required: true
  },
  status: {
    type: String,
    enum: ['active', 'blocked', 'expired'],
    default: 'active'
  },
  pin: {
    type: String,
    required: true
  },
  issuedDate: {
    type: Date,
    default: Date.now
  }
}, {
  timestamps: true
});

// Generate card details before saving
cardSchema.pre('save', function(next) {
  if (this.isNew) {
    // Generate 16-digit card number starting with 4111 (similar to Visa format)
    this.cardNumber = '4111' + Math.floor(Math.random() * 1000000000000).toString().padStart(12, '0');
    
    // Generate 3-digit CVV
    this.cvv = Math.floor(Math.random() * 900 + 100).toString();
    
    // Set expiry date to 5 years from now
    const expiryDate = new Date();
    expiryDate.setFullYear(expiryDate.getFullYear() + 5);
    this.expiryDate = expiryDate;
  }
  next();
});

const Card = mongoose.model('Card', cardSchema);

module.exports = Card; 