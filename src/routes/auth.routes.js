const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const User = require('../models/user.model');
const OTP = require('../models/otp.model');
const { auth } = require('../middleware/auth.middleware');
const { sendEmail } = require('../utils/email.util');

// Register new user
router.post('/register', async (req, res) => {
  try {
    const { fullName, email, password, phone, cnic, address } = req.body;

    // Check if user already exists
    const existingUser = await User.findOne({
      $or: [{ email }, { phone }, { cnic }]
    });

    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: 'User already exists with this email, phone, or CNIC'
      });
    }

    // Create new user
    const user = new User({
      fullName,
      email,
      password,
      phone,
      cnic,
      address
    });

    await user.save();

    // Generate OTP for email verification
    const otp = new OTP({
      user: user._id,
      email,
      purpose: 'registration'
    });

    await otp.save();

    // Send OTP via email
    await sendEmail(email, 'Email Verification', `Your OTP is: ${otp.otp}`);

    res.status(201).json({
      success: true,
      message: 'Registration successful. Please verify your email with the OTP sent.'
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Registration failed',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

// Verify email with OTP
router.post('/verify-email', async (req, res) => {
  try {
    const { email, otp } = req.body;

    const otpRecord = await OTP.findOne({
      email,
      purpose: 'registration',
      isUsed: false
    }).sort({ createdAt: -1 });

    if (!otpRecord || !otpRecord.verifyOTP(otp)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid or expired OTP'
      });
    }

    // Mark OTP as used
    otpRecord.isUsed = true;
    await otpRecord.save();

    // Update user's email verification status
    await User.findOneAndUpdate(
      { email },
      { emailVerified: true }
    );

    res.json({
      success: true,
      message: 'Email verified successfully'
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Email verification failed',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

// Login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials'
      });
    }

    // Check password
    const isMatch = await user.comparePassword(password);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials'
      });
    }

    // Check if email is verified
    if (!user.emailVerified) {
      return res.status(401).json({
        success: false,
        message: 'Please verify your email first'
      });
    }

    // Check if account is active
    if (user.status !== 'active') {
      return res.status(401).json({
        success: false,
        message: 'Account is not active. Please contact support.'
      });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user._id },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({
      success: true,
      token,
      user: {
        id: user._id,
        fullName: user.fullName,
        email: user.email,
        role: user.role,
        accountNumber: user.accountNumber
      }
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Login failed',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

// Request password reset
router.post('/forgot-password', async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    // Generate OTP for password reset
    const otp = new OTP({
      user: user._id,
      email,
      purpose: 'reset_password'
    });

    await otp.save();

    // Send OTP via email
    await sendEmail(email, 'Password Reset', `Your OTP for password reset is: ${otp.otp}`);

    res.json({
      success: true,
      message: 'Password reset OTP sent to your email'
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Failed to initiate password reset',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

// Reset password with OTP
router.post('/reset-password', async (req, res) => {
  try {
    const { email, otp, newPassword } = req.body;

    const otpRecord = await OTP.findOne({
      email,
      purpose: 'reset_password',
      isUsed: false
    }).sort({ createdAt: -1 });

    if (!otpRecord || !otpRecord.verifyOTP(otp)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid or expired OTP'
      });
    }

    // Mark OTP as used
    otpRecord.isUsed = true;
    await otpRecord.save();

    // Update password
    const user = await User.findOne({ email });
    user.password = newPassword;
    await user.save();

    res.json({
      success: true,
      message: 'Password reset successful'
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Password reset failed',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

// Update biometric status
router.post('/biometric', auth, async (req, res) => {
  try {
    const { enabled } = req.body;

    req.user.biometricEnabled = enabled;
    await req.user.save();

    res.json({
      success: true,
      message: `Biometric authentication ${enabled ? 'enabled' : 'disabled'}`
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Failed to update biometric status',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

module.exports = router; 