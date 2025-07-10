const mongoose = require('mongoose');

const chequeSchema = new mongoose.Schema({
  chequeNumber: {
    type: String,
    required: true
  },
  status: {
    type: String,
    enum: ['unused', 'used', 'cancelled'],
    default: 'unused'
  },
  usedDate: {
    type: Date
  },
  amount: {
    type: Number
  }
});

const chequeBookSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  bookNumber: {
    type: String,
    unique: true,
    required: true
  },
  startNumber: {
    type: String,
    required: true
  },
  endNumber: {
    type: String,
    required: true
  },
  cheques: [chequeSchema],
  status: {
    type: String,
    enum: ['active', 'completed', 'cancelled'],
    default: 'active'
  },
  issuedDate: {
    type: Date,
    default: Date.now
  }
}, {
  timestamps: true
});

// Generate cheque book details before saving
chequeBookSchema.pre('save', function(next) {
  if (this.isNew) {
    // Generate book number
    this.bookNumber = 'CB' + Date.now() + Math.floor(Math.random() * 1000).toString().padStart(3, '0');
    
    // Generate 20 cheques for the book
    const startNum = parseInt(this.startNumber);
    for (let i = 0; i < 20; i++) {
      this.cheques.push({
        chequeNumber: (startNum + i).toString().padStart(6, '0'),
        status: 'unused'
      });
    }
    this.endNumber = (startNum + 19).toString().padStart(6, '0');
  }
  next();
});

const ChequeBook = mongoose.model('ChequeBook', chequeBookSchema);

module.exports = ChequeBook; 