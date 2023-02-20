import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/models/player.dart';

class RoomProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  List<String> _boardElements = List<String>.filled(9, '');

  Player _player1 =
      Player(nickName: '', socketId: '', points: 0, playerType: 'X');
  Player _player2 =
      Player(nickName: '', socketId: '', points: 0, playerType: 'O');

  int _filledBoxes =0;


  Player get player1 => _player1;
  Player get player2 => _player2;

  Map<String, dynamic> get roomData => _roomData;

  List<String> get boardElements => _boardElements;

  int get filledBoxes => _filledBoxes; 

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> playerData) {
    _player1 = Player.fromMap(playerData);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> playerData) {
    _player2 = Player.fromMap(playerData);
    notifyListeners();
  }

  void updateBoardElements(int index, String choice) {
    _boardElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void resetBoardElements(){
    _boardElements = List<String>.filled(9, '');
    _filledBoxes = 0;
    notifyListeners();
  }
}
