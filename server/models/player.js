const mongoose = require('mongoose');

const playerSchema =new mongoose.Schema({
    nickName:{
        type:String,
        trim: true
    },
    socketId:{
        type:String,
    },
    points:{
        type:Number,
        default:0
    },
    playerType:{
        type:String,
        required: true,
    }
});

module.exports = playerSchema;

