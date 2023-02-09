import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/providers/room_provider.dart';
import 'package:tic_tac_toe/utils/util.dart';

class SocketMethods {
  final socketClient = SocketClient.instance.socket;

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      socketClient!.emit('createRoom', {'nickName': nickName});
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      socketClient!.emit('joinRoom', {'nickName': nickName, 'roomId': roomId});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    socketClient!.on('createRoomSuccess', (room) {
      Provider.of<RoomProvider>(context, listen: false).updateRoomData(room);
      print("room created :${room}");
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    socketClient!.on('joinRoomSuccess', (room) {
      Provider.of<RoomProvider>(context, listen: false).updateRoomData(room);
      print("join successfull :${room}");
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorListener(BuildContext context) {
    socketClient!.on('errorOccured', (message) {
      showSnackbar(context, message);
    });
  }

  void playerStateUpdateListener(BuildContext context) {
    socketClient!.on('playersUpdated', (playerData) {
      Provider.of<RoomProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

    void updateRoomListener(BuildContext context) {
    socketClient!.on('updateRoom', (room) {
      Provider.of<RoomProvider>(context, listen: false).updateRoomData(room);
    });
  }
}
