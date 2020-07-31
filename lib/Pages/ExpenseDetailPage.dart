import 'package:budget_planner/ExpenseCategory.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner/DetailCard.dart';

class ExpenseDetailPage extends StatefulWidget {
  final ExpenseCategory expense;

  ExpenseDetailPage({@required this.expense});

  @override
  _ExpenseDetailPageState createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getCustomAppBar(context, widget.expense),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: DetailCard(),
                  );
                },
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_getCustomAppBar(BuildContext context, ExpenseCategory expense) {
  return PreferredSize(
    preferredSize: Size.fromHeight(80),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: expense.categoryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(expense.categoryIcon),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "${expense.name} \$${expense.expense}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
