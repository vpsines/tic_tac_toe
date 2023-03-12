import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/providers/room_provider.dart';
import 'package:tic_tac_toe/utils/util.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    String winner = '';
    RoomProvider roomProvider =
        Provider.of<RoomProvider>(context, listen: false);

    List<String> boardElements = roomProvider.boardElements;

    // check for row wins

    if (boardElements[0] == boardElements[1] &&
        boardElements[1] == boardElements[2] &&
        boardElements[0].isNotEmpty) {
      winner = boardElements[0];
    }

    if (boardElements[3] == boardElements[4] &&
        boardElements[4] == boardElements[5] &&
        boardElements[3].isNotEmpty) {
      winner = boardElements[3];
    }

    if (boardElements[6] == boardElements[7] &&
        boardElements[7] == boardElements[8] &&
        boardElements[6].isNotEmpty) {
      winner = boardElements[6];
    }

    // check for column wins

    if (boardElements[0] == boardElements[3] &&
        boardElements[3] == boardElements[6] &&
        boardElements[0].isNotEmpty) {
      winner = boardElements[0];
    }
    if (boardElements[1] == boardElements[4] &&
        boardElements[4] == boardElements[7] &&
        boardElements[1].isNotEmpty) {
      winner = boardElements[1];
    }
    if (boardElements[2] == boardElements[5] &&
        boardElements[5] == boardElements[8] &&
        boardElements[2].isNotEmpty) {
      winner = boardElements[2];
    }

    // check for diagonal wins
    if (boardElements[0] == boardElements[4] &&
        boardElements[4] == boardElements[8] &&
        boardElements[0].isNotEmpty) {
      winner = boardElements[0];
    }

    if (boardElements[2] == boardElements[4] &&
        boardElements[4] == boardElements[6] &&
        boardElements[2].isNotEmpty) {
      winner = boardElements[2];
    } else if (roomProvider.filledBoxes == 9) {
      winner = '';
    }

    if (winner != '') {
      if (winner == roomProvider.player1.playerType) {
        showGameDialog(context, '${roomProvider.player1.nickName} won!');
        socketClient.emit('winner', {
          'winnerSocketId': roomProvider.player1.socketId,
          'roomId': roomProvider.roomData['_id']
        });
      } else {
        showGameDialog(context, '${roomProvider.player2.nickName} won!');

        socketClient.emit('winner', {
          'winnerSocketId': roomProvider.player2.socketId,
          'roomId': roomProvider.roomData['_id']
        });
      }
    }
  }

  void resetBoard(BuildContext context){
        RoomProvider roomProvider =
        Provider.of<RoomProvider>(context, listen: false);
        roomProvider.resetBoardElements();
  }
}
