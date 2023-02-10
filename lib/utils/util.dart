import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: () {
            GameMethods().resetBoard(context);
            Navigator.of(context).pop();
          }, child: const Text('Play again'))
        ],
      );
    },
  );
}
