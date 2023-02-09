// import modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

require('dotenv').config();
const app = express();

const PORT = process.env.PORT || 3000;
const mongoUri = process.env.MONGO_URI;

var server = http.createServer(app);
var io = require("socket.io")(server);

// middleware
app.use(express.json());

io.on("connection",(socket)=>{
    console.log("socket connection successfull..");
    socket.on("createRoom",({nickName})=>{
      console.log(nickName);
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
