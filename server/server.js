// import modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");

require("dotenv").config();
const app = express();

const PORT = process.env.PORT || 3000;
const mongoUri = process.env.MONGO_URI;

var server = http.createServer(app);
var io = require("socket.io")(server);

// middleware
app.use(express.json());

io.on("connect_error", (err) => {
  console.log(`connect_error due to ${err.message}`);
});

io.on("connection", (socket) => {
  console.log("socket connection successfull..");

  socket.on("createRoom", async ({ nickName }) => {
    try {
      console.log(nickName);

      // create room
      let room = new Room();
      let player = {
        socketId: socket.id,
        nickName,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;

      // save room
      room = await room.save();

      const roomId = room._id.toString();
      socket.join(roomId);

      // inform client on room created
      io.to(roomId).emit('createRoomSuccess',room);

    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom",async ({nickName,roomId})=> {
    try{
      
      // check if room id is valid
      if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
        socket.emit('errorOccurred',"Please enter a valid room id.");
        return;
      }

      let room = await Room.findById(roomId);
      
      // check if room is available for joining
      if(room.isJoin){
        let player = {
          nickName,
          socketId: socket.id,
          playerType: 'O',
        };
        socket.join(roomId);

        // save player
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();

        io.emit('joinRoomSuccess',room);
        io.emit('playersUpdated',room.players);
        io.emit('updateRoom',room);
      }else{
        socket.emit('errorOccurred',"Game in progress.Please try again later");
      }

    }catch(e){
      console.log(e);
    }
  });
});

mongoose
  .connect(mongoUri)
  .then(() => {
    console.log("Connected successfully");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server started and running on port: ${PORT}`);
});
