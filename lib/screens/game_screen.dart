import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/widgets/score_board.dart';
import 'package:tic_tac_toe/widgets/tic_tac_toe_board.dart';
import 'package:tic_tac_toe/widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static const String routeName = '/game';

  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    socketMethods.updateRoomListener(context);
    socketMethods.playerStateUpdateListener(context);
    socketMethods.pointIncreaseListener(context);
    socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, roomProvider, child) {
        return Scaffold(
          body: (roomProvider.roomData['isJoin'])
              ? const WaitingLobby()
              : SafeArea(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ScoreBoard(),
                    const TicTacToeBoard(),
                    Text('${roomProvider.roomData['turn']['nickName']}\'s turn')
                  ],
                )),
        );
      },
    );
  }
}
