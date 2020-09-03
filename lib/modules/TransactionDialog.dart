import 'package:flutter/material.dart';
import 'package:budget_planner/classes/ExpenseDetail.dart';
import 'package:intl/intl.dart';

Future<ExpenseDetail> addTransactionDialog(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime t;

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                  padding: const EdgeInsets.all(16.0),
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
                            t == null
                                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                                : DateFormat('yyyy-MM-dd').format(t),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: t == null ? DateTime.now() : t,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2030),
                              ).then((value) {
                                setState(() {
                                  if (value != null) {
                                    t = value;
                                  }
                                });
                              });
                            },
                            color: Colors.grey[800],
                            child: Text(
                              "Select Date",
                              style: TextStyle(
                                color: Colors.blue,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {
                              if (titleController.text.isNotEmpty &&
                                  amountController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty) {
                                ExpenseDetail e = ExpenseDetail(
                                  title: titleController.text,
                                  amount: double.parse(amountController.text),
                                  t: t == null ? DateTime.now() : t,
                                  description: descriptionController.text,
                                );
                                Navigator.of(context).pop(e);
                              }
                            },
                            color: Colors.grey[800],
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.grey[800],
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}
