import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_glow_text.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController nameController = TextEditingController();
  SocketMethods socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    nameController.dispose();
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
                text: 'Create Room',
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                fontSize: 17),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomTextField(
                hintText: 'Enter your nick name', controller: nameController),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomButton(
                onTap: () =>
                    socketMethods.createRoom(nameController.text.trim()),
                buttonText: "Create")
          ],
        ),
      ),
    );
  }
}
