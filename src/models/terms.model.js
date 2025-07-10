const mongoose = require('mongoose');

const termsSchema = new mongoose.Schema({
    accountType: {
        type: String,
        enum: ['premium', 'gold', 'silver', 'classic'],
        required: true
    },
    version: {
        type: String,
        required: true
    },
    effectiveDate: {
        type: Date,
        default: Date.now
    },
    generalTerms: [{
        type: String,
        required: true
    }],
    accountSpecificTerms: [{
        type: String,
        required: true
    }],
    feesAndCharges: [{
        type: String,
        required: true
    }],
    benefitsAndPrivileges: [{
        type: String,
        required: true
    }],
    isActive: {
        type: Boolean,
        default: true
    }
}, {
    timestamps: true
});

// Method to get current active terms for an account type
termsSchema.statics.getCurrentTerms = async function(accountType) {
    return await this.findOne({ accountType, isActive: true })
        .sort({ effectiveDate: -1 })
        .exec();
};

// Default terms and conditions for each account type
termsSchema.statics.getDefaultTerms = function(accountType) {
    const baseTerms = [
        'Account holder must be 18 years or older',
        'Valid identification documents required',
        'Bank reserves the right to modify terms with notice',
        'Account holder responsible for maintaining minimum balance',
        'Regular account statements will be provided'
    ];

    const accountTerms = {
        premium: {
            specific: [
                'Minimum balance of $10,000 required',
                'No monthly maintenance fee',
                'Unlimited free transactions',
                'Priority processing for all banking services',
                'Dedicated relationship manager'
            ],
            fees: [
                'No monthly maintenance fee',
                'Free international wire transfers',
                'Free premium credit card',
                'Free safe deposit box'
            ],
            benefits: [
                'Exclusive premium credit card',
                'Unlimited ATM fee rebates worldwide',
                'Preferential foreign exchange rates',
                'Complimentary financial advisory services',
                'Access to exclusive banking lounges',
                'Priority customer service 24/7',
                'Comprehensive travel insurance'
            ]
        },
        gold: {
            specific: [
                'Minimum balance of $5,000 required',
                '$10 monthly maintenance fee',
                'Up to 100 free transactions per month',
                'Preferential service at branches'
            ],
            fees: [
                '$10 monthly maintenance fee',
                'Reduced rates on international transfers',
                'Discounted safe deposit box'
            ],
            benefits: [
                'Gold tier credit card',
                'ATM fee rebates (domestic)',
                'Preferential loan rates',
                'Extended banking hours support',
                'Travel insurance options'
            ]
        },
        silver: {
            specific: [
                'Minimum balance of $2,500 required',
                '$15 monthly maintenance fee',
                'Up to 50 free transactions per month',
                'Standard service processing'
            ],
            fees: [
                '$15 monthly maintenance fee',
                'Standard transaction fees apply after free limit',
                'Standard rates for additional services'
            ],
            benefits: [
                'Silver tier credit card',
                'Online and mobile banking',
                'Basic insurance options',
                'Standard customer support'
            ]
        },
        classic: {
            specific: [
                'Minimum balance of $1,000 required',
                '$20 monthly maintenance fee',
                'Up to 25 free transactions per month',
                'Standard service processing'
            ],
            fees: [
                '$20 monthly maintenance fee',
                'Standard transaction fees',
                'Additional service fees apply'
            ],
            benefits: [
                'Basic credit card option',
                'Online and mobile banking',
                'Standard ATM access',
                'Basic customer support'
            ]
        }
    };

    return {
        generalTerms: baseTerms,
        accountSpecificTerms: accountTerms[accountType].specific,
        feesAndCharges: accountTerms[accountType].fees,
        benefitsAndPrivileges: accountTerms[accountType].benefits
    };
};

const Terms = mongoose.model('Terms', termsSchema);

module.exports = Terms; 