const config = require('../config/config');
const { sendEmail } = require('../utils/email.util');

class NotificationService {
  constructor() {
    this.notificationMethod = config.notifications.method;
    this.enablePush = config.notifications.enablePush;
  }

  async sendNotification(userId, type, data) {
    try {
      switch (this.notificationMethod) {
        case 'email':
          await this.sendEmailNotification(userId, type, data);
          break;
        case 'push':
          if (this.enablePush) {
            await this.sendPushNotification(userId, type, data);
          }
          break;
        case 'none':
          // Do nothing if notifications are disabled
          break;
        default:
          throw new Error('Invalid notification method');
      }
    } catch (error) {
      console.error('Notification error:', error);
      throw new Error('Failed to send notification');
    }
  }

  async sendEmailNotification(userId, type, data) {
    const templates = {
      transaction: {
        subject: 'Transaction Notification',
        body: (data) => `
          Dear Customer,

          A ${data.type} transaction of ${data.amount} has been ${data.status} in your account.
          
          Transaction Details:
          - Amount: ${data.amount}
          - Type: ${data.type}
          - Status: ${data.status}
          - Date: ${new Date().toLocaleString()}
          ${data.reference ? `- Reference: ${data.reference}` : ''}

          If you did not authorize this transaction, please contact us immediately.

          Best regards,
          Your Bank
        `
      },
      account: {
        subject: 'Account Update Notification',
        body: (data) => `
          Dear Customer,

          Your account status has been updated.
          
          Update Details:
          - Type: ${data.type}
          - Status: ${data.status}
          - Date: ${new Date().toLocaleString()}

          If you did not authorize this change, please contact us immediately.

          Best regards,
          Your Bank
        `
      },
      card: {
        subject: 'Card Status Update',
        body: (data) => `
          Dear Customer,

          Your card status has been updated.
          
          Card Details:
          - Card Number: XXXX-XXXX-XXXX-${data.cardNumber.slice(-4)}
          - Status: ${data.status}
          - Date: ${new Date().toLocaleString()}

          If you did not authorize this change, please contact us immediately.

          Best regards,
          Your Bank
        `
      },
      security: {
        subject: 'Security Alert',
        body: (data) => `
          Dear Customer,

          A security event has been detected on your account.
          
          Alert Details:
          - Type: ${data.type}
          - Description: ${data.description}
          - Date: ${new Date().toLocaleString()}
          - Location: ${data.location || 'Unknown'}

          If this wasn't you, please contact us immediately.

          Best regards,
          Your Bank
        `
      }
    };

    const template = templates[type];
    if (!template) {
      throw new Error('Invalid notification type');
    }

    await sendEmail(
      data.email,
      template.subject,
      template.body(data)
    );
  }

  async sendPushNotification(userId, type, data) {
    // Implement push notifications here if needed
    // This is a placeholder for future implementation
    console.log('Push notification not implemented yet');
  }

  // Helper method to format currency
  formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  }
}

module.exports = new NotificationService(); 