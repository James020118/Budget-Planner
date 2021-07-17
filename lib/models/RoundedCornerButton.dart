import 'package:flutter/material.dart';

class RoundedCornerButton extends StatelessWidget {
  RoundedCornerButton(
    this.text, {
    Key? key,
    this.buttonColor = Colors.blue,
    this.buttonBorderRadius = 18.0,
    this.buttonBorderColor = Colors.black,
    required this.onPressed,
    this.textColor = Colors.black,
  }) : super(key: key);

  final Color buttonColor;
  final double buttonBorderRadius;
  final Color buttonBorderColor;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
            side: BorderSide(color: buttonBorderColor),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
