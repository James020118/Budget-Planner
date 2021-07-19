import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:budget_planner/classes/ExpenseDetail.dart';
import 'RoundedCornerButton.dart';

Future<ExpenseDetail?> addTransactionDialog(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedTime;

  Widget _buildBottomButtonRow() {
    return Row(
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
              ExpenseDetail e = ExpenseDetail(
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
    );
  }

  Widget _buildDialogBody() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Enter Transaction Details:",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: titleController,
                            decoration: InputDecoration(
                              labelText: "Transaction Title",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: amountController,
                            decoration: InputDecoration(
                              labelText: "Transaction Amount",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
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
                              initialDate: selectedTime == null ? DateTime.now() : selectedTime!,
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: "Transaction Description",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildBottomButtonRow(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  return showDialog(
    context: context,
    builder: (context) {
      return _buildDialogBody();
    },
  );
}
