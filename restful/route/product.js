const express = require("express");
const router = express.Router();
const mongoose = require('mongoose');
const product = require("../models/product");

//find all product
router.get('/', (req, res, next) => {
    console.log(product)
    product.find()
        .then(products => {
            res.json(products);
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

//find product by id
router.get('/:id', (req, res) => {
    product.findById(req.params.id)
        .then(foundProduct => {
            if (!foundProduct) {
                res.status(404).json({ error: 'Product not found' });
            } else {
                res.json(foundProduct);
            }
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

// create new product
router.post('/', (req, res, next) => {
    product.create(req.body)
        .then(createdProduct => {
            res.status(201).json(createdProduct);
        })
        .catch(err => {
            console.error(err);
            console.log(err)
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

// Update a product by ID
router.put('/:id', (req, res, next) => {
    product.findByIdAndUpdate(req.params.id, req.body, { new: true })
        .then(updatedProduct => {
            if (!updatedProduct) {
                return res.status(404).json({ error: 'Product not found' });
            }
            res.json(updatedProduct);
        })
        .catch(err => {
            console.error(err);
            console.log(err)
            res.status(500).json({ error: 'Internal Server Error' });
        });
});

// Delete a product by ID
router.delete('/:id', (req, res, next) => {
    product.findByIdAndDelete(req.params.id)
        .then(deletedProduct => {
            if (!deletedProduct) {
                return res.status(404).json({ error: 'Product not found' });
            }
            res.status(204).send(); // 204 No Content for a successful deletion
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal Server Error' });
        });
});


module.exports = router