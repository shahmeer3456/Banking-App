const mongoose = require('mongoose');

const otpSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  email: {
    type: String,
    required: true
  },
  otp: {
    type: String,
    required: true
  },
  purpose: {
    type: String,
    enum: ['registration', 'login', 'reset_password', 'transaction'],
    required: true
  },
  expiresAt: {
    type: Date,
    required: true,
    default: function() {
      // OTP expires in 10 minutes
      return new Date(Date.now() + 10 * 60 * 1000);
    }
  },
  isUsed: {
    type: Boolean,
    default: false
  }
}, {
  timestamps: true
});

// Index to automatically delete expired OTPs
otpSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 });

// Method to verify OTP
otpSchema.methods.verifyOTP = function(inputOTP) {
  return this.otp === inputOTP && !this.isUsed && new Date() < this.expiresAt;
};

// Generate OTP before saving
otpSchema.pre('save', function(next) {
  if (this.isNew) {
    // Generate 6-digit OTP
    this.otp = Math.floor(100000 + Math.random() * 900000).toString();
  }
  next();
});

const OTP = mongoose.model('OTP', otpSchema);

module.exports = OTP; 