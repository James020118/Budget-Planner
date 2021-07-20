import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'rounded_corner_button.dart';

Future<dynamic> createCustomDialogWithTextField({
  required BuildContext context,
  required String title,
  required String button1Text,
  required String button2Text,
  required TextEditingController controller,
  String? textFieldLabelText,
  String? textFieldHintText,
  String? textFieldPrefilledString,
  List<TextInputFormatter>? textFieldInputFormatters,
  Function()? createReturnObject,
}) {
  if (textFieldPrefilledString != null) {
    controller.text = textFieldPrefilledString;
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RoundedCornerButton(
          button1Text,
          buttonColor: Colors.grey[800]!,
          isTextBold: true,
          onPressed: () {
            if (controller.text.isNotEmpty) {
              final returnObject = createReturnObject != null ? createReturnObject() : null;
              Navigator.of(context).pop(returnObject);
            }
          },
        ),
        RoundedCornerButton(
          button2Text,
          buttonColor: Colors.grey[800]!,
          buttonBorderColor: Colors.red,
          textColor: Colors.red,
          isTextBold: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildDialogBody() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: controller,
                      keyboardType: TextInputType.number,
                      // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                      inputFormatters: textFieldInputFormatters,
                      decoration: InputDecoration(
                        labelText: textFieldLabelText,
                        hintText: textFieldHintText,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildButtonRow(),
            ],
          ),
        ),
      ),
    );
  }

  return showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: _buildDialogBody(),
      );
    },
  );
}
