const express = require("express");
const router = express.Router();
const mongoose = require('mongoose');
const room = require("../models/room");

//find all room
router.get('/', (req, res, next) => {
    console.log(room)
    room.find()
        .then(rooms => {
            res.json(rooms);
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
}); 

//find room by id
router.get('/:roomNumber', (req, res) => {
    room.findById(req.params.id)
        .then(foundRoom => {
            if (!foundRoom) {
                res.status(404).json({ error: 'Product not found' });
            } else {
                res.json(foundRoom);
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

// create new room
router.post('/', (req, res, next) => {
    console.log('Received POST request');
    console.log('Request Body:', req.body);
    
    room.create(req.body)
        .then(createdRoom => {
            res.status(201).json(createdRoom);
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

// Update a room by ID
router.put('/:id', (req, res, next) => {
    room.findByIdAndUpdate(req.params.id, req.body, { new: true })
        .then(updatedRoom => {
            if (!updatedRoom) {
                return res.status(404).json({ error: 'Room not found' });
            }
            res.json(updatedRoom);
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

// Delete a room by ID
router.delete('/:id', (req, res, next) => {
    room.findByIdAndDelete(req.params.id)
        .then(deletedRoom => {
            if (!deletedRoom) {
                return res.status(404).json({ error: 'Room not found' });
            }
            res.status(204).send(); // 204 No Content for a successful deletion
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});


module.exports = router