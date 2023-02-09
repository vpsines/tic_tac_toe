import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_glow_text.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  static const String routeName = '/join-room';

  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final SocketMethods socketMethods = SocketMethods();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController gameIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    socketMethods.joinRoomSuccessListener(context);
    socketMethods.errorListener(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomGlowText(
                text: 'Join Room',
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                fontSize: 17),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomTextField(
                hintText: 'Enter your nick name', controller: nameController),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                hintText: 'Enter gameId', controller: gameIdController),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomButton(
                onTap: () {
                  socketMethods.joinRoom(
                      nameController.text.trim(), gameIdController.text.trim());
                },
                buttonText: "Join")
          ],
        ),
      ),
    );
  }
}
