import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/models/player.dart';

class RoomProvider extends ChangeNotifier{
  Map<String,dynamic> _roomData = {};
  Player _player1 = Player(nickName: '', socketId: '', points: 0, playerType: 'X');
  Player _player2 = Player(nickName: '', socketId: '', points: 0, playerType: 'O');

  Player get player1 => _player1;
  Player get player2 => _player2;

  Map<String,dynamic> get roomData => _roomData;

  void updateRoomData(Map<String,dynamic> data){
    _roomData = data;
    notifyListeners();
  }

 void updatePlayer1(Map<String,dynamic> playerData){
    _player1 = Player.fromMap(playerData);
    notifyListeners();
  }

  void updatePlayer2(Map<String,dynamic> playerData){
    _player2 = Player.fromMap(playerData);
    notifyListeners();
  }
}