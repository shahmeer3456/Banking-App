const nodemailer = require('nodemailer');

// Create transporter
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  secure: process.env.SMTP_SECURE === 'true',
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS
  }
});

// Send email function
const sendEmail = async (to, subject, text) => {
  try {
    const mailOptions = {
      from: process.env.SMTP_FROM,
      to,
      subject,
      text
    };

    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error('Email sending failed:', error);
    throw new Error('Failed to send email');
  }
};

module.exports = {
  sendEmail
}; 