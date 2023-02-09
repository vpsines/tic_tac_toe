import 'package:flutter/material.dart';

class CustomGlowText extends StatelessWidget {
  final String text;
  final List<Shadow> shadows;
  final double fontSize;
  
  const CustomGlowText({super.key, required this.text, required this.shadows, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        shadows: shadows,
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold
      ),
    );
  }
}