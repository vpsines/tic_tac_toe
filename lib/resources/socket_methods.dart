import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/providers/room_provider.dart';
import 'package:tic_tac_toe/utils/util.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;

  Socket get socketClient => _socketClient!;

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient!.emit('createRoom', {'nickName': nickName});
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient!.emit('joinRoom', {'nickName': nickName, 'roomId': roomId});
    }
  }

  void onBoardTap(int index, String roomId, List<String> boardElements) {
    if (boardElements[index].isEmpty) {
      _socketClient!.emit('boardTap', {'index': index, 'roomId': roomId});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient!.on('createRoomSuccess', (room) {
      Provider.of<RoomProvider>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient!.on('joinRoomSuccess', (room) {
      Provider.of<RoomProvider>(context, listen: false).updateRoomData(room);
      print("join successfull :${room}");
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorListener(BuildContext context) {
    _socketClient!.on('errorOccured', (message) {
      showSnackbar(context, message);
    });
  }

  void playerStateUpdateListener(BuildContext context) {
    _socketClient!.on('playersUpdated', (playerData) {
      Provider.of<RoomProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient!.on('updateRoom', (room) {
      Provider.of<RoomProvider>(context, listen: false).updateRoomData(room);
    });
  }

  void boardTapListener(BuildContext context){
    _socketClient!.on('boardTapped', (data){
      RoomProvider roomProvider = Provider.of<RoomProvider>(context, listen: false);
      roomProvider.updateBoardElements(data['index'], data['choice']);
      roomProvider.updateRoomData(data['room']);
    });
  }
}
