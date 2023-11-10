const express = require('express')
const app = express()
const members = require('./member.json')
const bodyParser = require('body-parser')
const mongoose = require('mongoose')

const product = require('./route/product')

mongoose.Promise = global.Promise
// เปลี่ยน password ด้วย
mongoose.connect('mongodb+srv://supanut:S1998mark1016@clusterpos.15iddpc.mongodb.net/?retryWrites=true&w=majority')
    .then(() => console.log("connection successfully"))
    .catch((err) => console.error(err))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended : true}))
app.use('/products', product)
app.get('/',(req,res) => {
    res.send('Hello World')
})
app.get('/member' , (req,res) => {
    res.json(members)
})
app.get('/member/:id' , (req,res) => {
    res.json(members.find(member => member.id === req.params.id))
})
app.post('/member' , (req,res) => {
    members.push(req.body)
    res.status(201).json(req.body)
})
app.put('/member/:id',(req,res) => {
    const updateIndex = members.findIndex(member => member.id === req.params.id)
    res.json(Object.assign(members[updateIndex],req.body))
})
app.delete('/member/:id' , (req,res) => {
    const deletedIndex = members.findIndex(member => member.id === req.params.id)
    members.splice(deletedIndex,1)
    res.status(204).send()
})
app.listen(4200, () => {
    console.log("start server at port 4200")
})