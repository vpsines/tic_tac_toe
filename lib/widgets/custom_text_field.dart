import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isReadOnly;
  final TextEditingController controller;

  const CustomTextField(
      {super.key, required this.hintText, required this.controller,this.isReadOnly=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.blue, spreadRadius: 2, blurRadius: 5)
      ]),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
            fillColor: backgroundColor, filled: true, hintText: hintText),
      ),
    );
  }
}
