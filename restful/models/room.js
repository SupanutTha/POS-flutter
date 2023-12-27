const mongoose = require('mongoose');

const ImageSchema = new mongoose.Schema({
    url: {
        type: String,
        required: false
    },
    format: {
        type: String,
        enum: ['jpeg', 'jpg'],
        default: 'jpeg'
    }
});

const RoomSchema = new mongoose.Schema({
    roomNumber: {
        type: String,
        required: true
    },
    roomType: {
        type: String,
        enum: ['Standard', 'Deluxe', 'Suite', 'Family Room'],
        required: true
    },
    occupancyStatus: {
        type: String,
        enum: ['vacant', 'occupied', 'maintenance'],
        default: 'vacant'
    },
    rate: {
        baseRate: {
            type: Number,
            required: true
        },
        currency: {
            type: String,
            default: 'THB'
        }
    },
    amenities: {
        type: [String],
        default: []
    },
    images: {
        type: [ImageSchema],
        default: []
    },
    description: String,
    features: {
        beds: {
            type: Number,
            default: 1
        },
        bedType: {
            type: String,
            enum: ['Single Bed', 'Double Bed'],
            default: 'Single Bed'
        },
        maxOccupancy: {
            type: Number,
            default: 2
        },
        isSmokingAllowed: {
            type: Boolean,
            default: false
        },
        hasBathtub: {
            type: Boolean,
            default: false
        },
        hasBalcony: {
            type: Boolean,
            default: false
        }
    },
    updated_at: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model('Room', RoomSchema);
