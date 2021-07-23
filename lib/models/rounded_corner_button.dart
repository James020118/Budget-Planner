import 'package:flutter/material.dart';

class RoundedCornerButton extends StatelessWidget {
  RoundedCornerButton(
    this.text, {
    Key? key,
    this.buttonColor = Colors.black,
    this.buttonBorderRadius = 18.0,
    this.buttonBorderColor = Colors.blue,
    required this.onPressed,
    this.textColor = Colors.blue,
    this.isTextBold = false,
  }) : super(key: key);

  final Color buttonColor;
  final double buttonBorderRadius;
  final Color buttonBorderColor;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final bool isTextBold;

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
          fontWeight: isTextBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
