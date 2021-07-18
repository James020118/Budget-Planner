import 'package:flutter/material.dart';

import 'package:budget_planner/main.dart';
import 'package:budget_planner/classes/ExpenseCategory.dart';
import 'package:budget_planner/models/RoundedCornerButton.dart';

class MenuPage extends StatefulWidget {
  final List<ExpenseCategory> allExpense;

  MenuPage({
    required this.allExpense,
  });

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoundedCornerButton(
                'Clear Month',
                buttonBorderColor: Colors.red,
                buttonColor: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _buildDialogBody();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(widget.allExpense);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Options",
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(width: MediaQuery.of(context).size.width / 9, height: 0.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogBody() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
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
                "Are you sure to clear month?",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RoundedCornerButton(
                    'Clear',
                    buttonColor: Colors.grey[800]!,
                    isTextBold: true,
                    onPressed: () {
                      for (int i = 0; i < widget.allExpense.length; i++) {
                        widget.allExpense[i].dets.clear();
                        widget.allExpense[i].expense = 0;
                      }
                      sharedPref.save("data", widget.allExpense);
                      Navigator.of(context).pop();
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
            ],
          ),
        ),
      ),
    );
  }
}
