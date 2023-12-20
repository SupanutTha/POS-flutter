const express = require('express')
const app = express()
const members = require('./member.json')
const bodyParser = require('body-parser')
const mongoose = require('mongoose')
const apiKeyMiddleware = require('./authMiddleware'); // Adjust the path as needed

app.use(express.json())
const product = require('./route/product')
const room = require('./route/room')
mongoose.Promise = global.Promise
// เปลี่ยน password ด้วย
mongoose.connect('mongodb+srv://supanut:S1998mark1016@clusterpos.15iddpc.mongodb.net/?retryWrites=true&w=majority')
    .then(() => console.log("connection successfully"))
    .catch((err) => console.error(err))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended : true}))

//route
// app.use('/products', product)
// app.use('/rooms',room)
app.use('/products', apiKeyMiddleware, product);
app.use('/rooms', apiKeyMiddleware, room);


app.listen(4200, () => {
    console.log("start server at port 4200")
})