const express = require('express');
const router = express.Router();
const Card = require('../models/card.model');
const authMiddleware = require('../middleware/auth.middleware');

// Get user's cards
router.get('/', authMiddleware, async (req, res) => {
    try {
        const cards = await Card.find({ user: req.user._id });
        res.json(cards);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Request new card
router.post('/request', authMiddleware, async (req, res) => {
    try {
        const { cardType } = req.body;

        // Check if user already has a card of this type
        const existingCard = await Card.findOne({
            user: req.user._id,
            cardType,
            status: { $in: ['active', 'pending'] }
        });

        if (existingCard) {
            return res.status(400).json({
                message: `You already have an ${existingCard.status} ${cardType} card`
            });
        }

        const card = new Card({
            user: req.user._id,
            cardType
        });

        await card.save();

        res.status(201).json({
            message: 'Card request submitted successfully',
            card: {
                cardType: card.cardType,
                status: card.status,
                cardNumber: card.cardNumber.slice(-4) // Only send last 4 digits
            }
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Get card details
router.get('/:cardId', authMiddleware, async (req, res) => {
    try {
        const card = await Card.findOne({
            _id: req.params.cardId,
            user: req.user._id
        });

        if (!card) {
            return res.status(404).json({ message: 'Card not found' });
        }

        res.json({
            cardType: card.cardType,
            status: card.status,
            cardNumber: card.cardNumber.slice(-4),
            expiryDate: card.expiryDate
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Block card
router.post('/:cardId/block', authMiddleware, async (req, res) => {
    try {
        const card = await Card.findOne({
            _id: req.params.cardId,
            user: req.user._id
        });

        if (!card) {
            return res.status(404).json({ message: 'Card not found' });
        }

        if (card.status === 'blocked') {
            return res.status(400).json({ message: 'Card is already blocked' });
        }

        card.status = 'blocked';
        await card.save();

        res.json({
            message: 'Card blocked successfully',
            status: card.status
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Change card PIN
router.post('/:cardId/change-pin', authMiddleware, async (req, res) => {
    try {
        const { currentPin, newPin } = req.body;
        const card = await Card.findOne({
            _id: req.params.cardId,
            user: req.user._id
        });

        if (!card) {
            return res.status(404).json({ message: 'Card not found' });
        }

        if (card.status !== 'active') {
            return res.status(400).json({ message: 'Card is not active' });
        }

        if (card.pin !== currentPin) {
            return res.status(400).json({ message: 'Current PIN is incorrect' });
        }

        if (!/^\d{4}$/.test(newPin)) {
            return res.status(400).json({ message: 'PIN must be 4 digits' });
        }

        card.pin = newPin;
        await card.save();

        res.json({ message: 'PIN changed successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router; 