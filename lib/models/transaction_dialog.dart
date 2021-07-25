import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:budget_planner/classes/expense_detail.dart';
import 'rounded_corner_button.dart';

Future<ExpenseDetail?> addTransactionDialog(BuildContext context) {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedTime;

  Widget _buildTitleTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            maxLength: 15,
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Transaction Title',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            maxLength: 8,
            controller: amountController,
            decoration: InputDecoration(
              labelText: 'Transaction Amount',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                selectedTime == null
                    ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                    : DateFormat('yyyy-MM-dd').format(selectedTime!),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              RoundedCornerButton(
                'Select Date',
                buttonColor: Colors.grey[800]!,
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate:
                        selectedTime == null ? DateTime.now() : selectedTime!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  ).then((value) {
                    setState(() {
                      if (value != null) {
                        selectedTime = value;
                      }
                    });
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Transaction Description',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtonRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RoundedCornerButton(
            'Add',
            buttonColor: Colors.grey[800]!,
            isTextBold: true,
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  amountController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                var e = ExpenseDetail(
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  t: selectedTime == null ? DateTime.now() : selectedTime!,
                  description: descriptionController.text,
                );
                Navigator.of(context).pop(e);
              }
            },
          ),
          RoundedCornerButton(
            'Cancel',
            buttonColor: Colors.grey[800]!,
            buttonBorderColor: Colors.red,
            textColor: Colors.red,
            isTextBold: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDialogBody() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[800],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Enter Transaction Details:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                _buildTitleTextField(),
                _buildAmountTextField(),
                _buildDatePicker(),
                _buildDescriptionTextField(),
                _buildBottomButtonRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return showDialog(
    context: context,
    builder: (context) {
      return _buildDialogBody();
    },
  );
}
