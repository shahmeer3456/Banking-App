require('dotenv').config();

const config = {
  // Server
  port: process.env.PORT || 3000,
  nodeEnv: process.env.NODE_ENV || 'development',

  // Database
  mongodb: {
    uri: process.env.MONGODB_URI || 'mongodb://localhost:27017/banking_app',
    testUri: process.env.MONGODB_URI_TEST || 'mongodb://localhost:27017/banking_app_test',
  },

  // JWT
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: process.env.JWT_EXPIRES_IN || '24h',
    refreshSecret: process.env.JWT_REFRESH_SECRET,
    refreshExpiresIn: process.env.JWT_REFRESH_EXPIRES_IN || '7d',
  },

  // Email (SMTP)
  smtp: {
    host: process.env.SMTP_HOST,
    port: parseInt(process.env.SMTP_PORT) || 587,
    secure: process.env.SMTP_SECURE === 'true',
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
    from: process.env.SMTP_FROM,
  },

  // Admin
  admin: {
    defaultEmail: process.env.ADMIN_DEFAULT_EMAIL,
    defaultPassword: process.env.ADMIN_DEFAULT_PASSWORD,
    phone: process.env.ADMIN_PHONE,
  },

  // Security
  security: {
    bcryptSaltRounds: parseInt(process.env.BCRYPT_SALT_ROUNDS) || 10,
    rateLimitWindowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS) || 900000,
    rateLimitMaxRequests: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS) || 100,
  },

  // Transaction Limits
  transactionLimits: {
    max: parseFloat(process.env.MAX_TRANSACTION_AMOUNT) || 1000000,
    min: parseFloat(process.env.MIN_TRANSACTION_AMOUNT) || 10,
    daily: parseFloat(process.env.DAILY_TRANSACTION_LIMIT) || 50000,
  },

  // Card Configuration
  card: {
    numberPrefix: process.env.CARD_NUMBER_PREFIX || '5412',
    expiryYears: parseInt(process.env.CARD_EXPIRY_YEARS) || 5,
  },

  // File Upload
  upload: {
    maxSize: parseInt(process.env.MAX_FILE_SIZE) || 5242880,
    allowedTypes: (process.env.ALLOWED_FILE_TYPES || 'image/jpeg,image/png,application/pdf').split(','),
  },

  // Logging
  logging: {
    level: process.env.LOG_LEVEL || 'debug',
    filePath: process.env.LOG_FILE_PATH || 'logs/app.log',
  },

  // Frontend URLs
  cors: {
    frontendUrl: process.env.FRONTEND_URL || 'http://localhost:3001',
    adminFrontendUrl: process.env.ADMIN_FRONTEND_URL || 'http://localhost:3002',
  },

  // Notifications
  notifications: {
    method: process.env.NOTIFICATION_METHOD || 'email',
    enablePush: process.env.ENABLE_PUSH_NOTIFICATIONS === 'true',
  },

  // Feature Flags
  features: {
    enable2FA: process.env.ENABLE_2FA === 'true',
    enableBiometric: process.env.ENABLE_BIOMETRIC === 'true',
    enableNotifications: process.env.ENABLE_NOTIFICATIONS === 'true',
    enableAutoLogout: process.env.ENABLE_AUTO_LOGOUT === 'true',
    autoLogoutTime: parseInt(process.env.AUTO_LOGOUT_TIME) || 30,
  },

  // Error Reporting
  errorReporting: {
    email: process.env.ERROR_REPORTING_EMAIL,
  },
};

// Validation
const requiredVars = [
  'JWT_SECRET',
  'MONGODB_URI',
  'SMTP_USER',
  'SMTP_PASS',
];

for (const variable of requiredVars) {
  if (!process.env[variable]) {
    throw new Error(`Required environment variable ${variable} is missing`);
  }
}

module.exports = config; 