import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/main-screen';
  const MainScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            buttonText: "Create Room",
            onTap: ()=>createRoom(context),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            buttonText: "Join Room",
            onTap: () => joinRoom(context),
          ),
        ],
      ),
    );
  }
}
