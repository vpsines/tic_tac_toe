import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_provider.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
        text:
            Provider.of<RoomProvider>(context, listen: false).roomData['_id']);
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Waiting for players to join..."),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: '',
          controller: roomIdController,
          isReadOnly: true,
        )
      ],
    );
  }
}
