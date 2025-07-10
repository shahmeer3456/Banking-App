const jwt = require('jsonwebtoken');
const User = require('../models/user.model');

const auth = async (req, res, next) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'No authentication token provided'
      });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const user = await User.findOne({ _id: decoded.userId, status: 'active' });

    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'User not found or account inactive'
      });
    }

    req.token = token;
    req.user = user;
    next();
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Please authenticate',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// Middleware to check if user is admin
const adminAuth = async (req, res, next) => {
  try {
    await auth(req, res, () => {
      if (req.user.role !== 'admin') {
        return res.status(403).json({
          success: false,
          message: 'Access denied. Admin privileges required.'
        });
      }
      next();
    });
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Please authenticate as admin',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// Middleware to check if user is employee or admin
const employeeAuth = async (req, res, next) => {
  try {
    await auth(req, res, () => {
      if (!['admin', 'employee'].includes(req.user.role)) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. Employee privileges required.'
        });
      }
      next();
    });
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Please authenticate as employee',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

module.exports = {
  auth,
  adminAuth,
  employeeAuth
}; 