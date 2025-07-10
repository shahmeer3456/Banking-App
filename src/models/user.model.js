const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
  fullName: {
    type: String,
    required: true,
    trim: true
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true
  },
  password: {
    type: String,
    required: true,
    minlength: 8
  },
  phone: {
    type: String,
    required: true,
    unique: true
  },
  cnic: {
    type: String,
    required: true,
    unique: true
  },
  address: {
    type: String,
    required: true
  },
  accountNumber: {
    type: String,
    unique: true,
    required: true
  },
  balance: {
    type: Number,
    default: 0
  },
  role: {
    type: String,
    enum: ['customer', 'admin', 'employee'],
    default: 'customer'
  },
  status: {
    type: String,
    enum: ['active', 'inactive', 'blocked'],
    default: 'active'
  },
  biometricEnabled: {
    type: Boolean,
    default: false
  },
  emailVerified: {
    type: Boolean,
    default: false
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
}, {
  timestamps: true
});

// Hash password before saving
userSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next();
  
  try {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
    next();
  } catch (error) {
    next(error);
  }
});

// Method to compare password
userSchema.methods.comparePassword = async function(candidatePassword) {
  return bcrypt.compare(candidatePassword, this.password);
};

// Generate account number
userSchema.pre('save', function(next) {
  if (this.isNew) {
    // Generate 16-digit account number starting with 1111
    this.accountNumber = '1111' + Math.floor(Math.random() * 1000000000000).toString().padStart(12, '0');
  }
  next();
});

const User = mongoose.model('User', userSchema);

module.exports = User; 