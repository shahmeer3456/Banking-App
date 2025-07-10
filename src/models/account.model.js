const mongoose = require('mongoose');

const accountSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    accountType: {
        type: String,
        enum: ['premium', 'gold', 'silver', 'classic'],
        required: true
    },
    balance: {
        type: Number,
        default: 0
    },
    minimumBalance: {
        type: Number,
        default: function() {
            switch (this.accountType) {
                case 'premium': return 10000;
                case 'gold': return 5000;
                case 'silver': return 2500;
                case 'classic': return 1000;
                default: return 0;
            }
        }
    },
    monthlyFee: {
        type: Number,
        default: function() {
            switch (this.accountType) {
                case 'premium': return 0;
                case 'gold': return 10;
                case 'silver': return 15;
                case 'classic': return 20;
                default: return 0;
            }
        }
    },
    features: {
        type: Map,
        of: Boolean,
        default: function() {
            const baseFeatures = {
                'atm_withdrawals': true,
                'online_banking': true,
                'mobile_banking': true
            };

            switch (this.accountType) {
                case 'premium':
                    return {
                        ...baseFeatures,
                        'priority_service': true,
                        'free_cheque_book': true,
                        'unlimited_transactions': true,
                        'international_transactions': true,
                        'premium_credit_card': true,
                        'wealth_management': true,
                        'concierge_service': true
                    };
                case 'gold':
                    return {
                        ...baseFeatures,
                        'priority_service': true,
                        'free_cheque_book': true,
                        'unlimited_transactions': true,
                        'international_transactions': true,
                        'premium_credit_card': true
                    };
                case 'silver':
                    return {
                        ...baseFeatures,
                        'free_cheque_book': true,
                        'unlimited_transactions': true,
                        'international_transactions': false
                    };
                case 'classic':
                    return {
                        ...baseFeatures,
                        'free_cheque_book': false,
                        'unlimited_transactions': false,
                        'international_transactions': false
                    };
                default:
                    return baseFeatures;
            }
        }
    },
    transactionLimits: {
        daily: {
            type: Number,
            default: function() {
                switch (this.accountType) {
                    case 'premium': return 50000;
                    case 'gold': return 25000;
                    case 'silver': return 10000;
                    case 'classic': return 5000;
                    default: return 1000;
                }
            }
        },
        monthly: {
            type: Number,
            default: function() {
                switch (this.accountType) {
                    case 'premium': return 1000000;
                    case 'gold': return 500000;
                    case 'silver': return 200000;
                    case 'classic': return 100000;
                    default: return 10000;
                }
            }
        }
    },
    status: {
        type: String,
        enum: ['active', 'inactive', 'frozen'],
        default: 'active'
    },
    openedDate: {
        type: Date,
        default: Date.now
    },
    lastFeeCharge: {
        type: Date,
        default: Date.now
    }
}, {
    timestamps: true
});

// Method to check if withdrawal is allowed
accountSchema.methods.canWithdraw = function(amount) {
    return this.balance - amount >= this.minimumBalance;
};

// Method to get account type details
accountSchema.statics.getAccountTypeDetails = function(type) {
    const details = {
        premium: {
            name: 'Premium Account',
            description: 'Our highest tier account with exclusive benefits and personalized service',
            minimumBalance: 10000,
            monthlyFee: 0,
            features: [
                'Priority customer service',
                'Free unlimited cheque books',
                'Unlimited free transactions',
                'International transactions',
                'Premium credit card',
                'Wealth management services',
                'Concierge services',
                'Higher transaction limits',
                'Zero monthly fees'
            ]
        },
        gold: {
            name: 'Gold Account',
            description: 'Enhanced banking experience with premium features',
            minimumBalance: 5000,
            monthlyFee: 10,
            features: [
                'Priority customer service',
                'Free cheque book',
                'Unlimited transactions',
                'International transactions',
                'Premium credit card',
                'Higher transaction limits'
            ]
        },
        silver: {
            name: 'Silver Account',
            description: 'Advanced banking features for growing needs',
            minimumBalance: 2500,
            monthlyFee: 15,
            features: [
                'Free cheque book',
                'Unlimited transactions',
                'Standard transaction limits',
                'Online and mobile banking'
            ]
        },
        classic: {
            name: 'Classic Account',
            description: 'Basic banking services for everyday needs',
            minimumBalance: 1000,
            monthlyFee: 20,
            features: [
                'Basic banking services',
                'ATM withdrawals',
                'Online and mobile banking',
                'Standard transaction limits'
            ]
        }
    };

    return type ? details[type] : details;
};

const Account = mongoose.model('Account', accountSchema);

module.exports = Account; 