import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods socketMethods = SocketMethods();

  void onGridItemTap(int index, RoomProvider roomProvider) {
    socketMethods.onBoardTap(
        index, roomProvider.roomData['_id'], roomProvider.boardElements);
  }

  @override
  void initState() {
    super.initState();
    socketMethods.boardTapListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7),
      child: AbsorbPointer(
        absorbing: roomProvider.roomData['turn']['socketId'] !=
            socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onGridItemTap(index, roomProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                ),
                child: Center(
                  child: Text(
                    roomProvider.boardElements[index],
                    style:
                        TextStyle(color: Colors.white, fontSize: 100, shadows: [
                      Shadow(
                          blurRadius: 40,
                          color: roomProvider.boardElements[index] == 'O'
                              ? Colors.red
                              : Colors.blue)
                    ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
