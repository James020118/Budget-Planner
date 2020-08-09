import 'package:budget_planner/classes/ExpenseCategory.dart';
import 'package:budget_planner/modules/ExpenseCard.dart';
import 'package:flutter/material.dart';
import 'ExpenseDetailPage.dart';
import 'package:budget_planner/modules/BudgetDialog.dart';
import 'package:budget_planner/modules/CategoryDialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalBudget = 0;
  double totalExpense = 0;

  // starting categories
  ExpenseCategory housing =
      ExpenseCategory("Housing", 0, Colors.orange, Icons.hotel, []);
  ExpenseCategory food =
      ExpenseCategory("Food", 0, Colors.purple, Icons.fastfood, []);
  ExpenseCategory bills =
      ExpenseCategory("Bills", 0, Colors.green, Icons.credit_card, []);
  ExpenseCategory entertainment = ExpenseCategory(
      "Entertainment", 0, Colors.lightBlue, Icons.local_play, []);
  ExpenseCategory clothing =
      ExpenseCategory("Clothing", 0, Colors.teal, Icons.shopping_basket, []);
  List<ExpenseCategory> categoryList = [];

  calculateTotalExpense() {
    totalExpense = 0;
    for (int i = 0; i < categoryList.length; i++) {
      totalExpense += categoryList[i].expense;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryList.add(housing);
      categoryList.add(food);
      categoryList.add(bills);
      categoryList.add(entertainment);
      categoryList.add(clothing);
      calculateTotalExpense();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  "Budget Planner",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: "\$${totalExpense.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 25,
                        color: totalExpense > totalBudget
                            ? Colors.red
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Avenir Next Rounded',
                      ),
                      children: [
                        TextSpan(
                          text: " / \$$totalBudget",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Avenir Next Rounded',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      createBudgetDialog(context).then((value) {
                        setState(() {
                          if (value != null) {
                            totalBudget = value;
                          }
                        });
                      });
                    },
                    child: Text(
                      "Modify Budget",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Text(
                "Details",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: "Delete",
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            categoryList.removeAt(index);
                            calculateTotalExpense();
                          });
                        },
                      ),
                    ],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpenseDetailPage(
                              expense: categoryList[index],
                            ),
                          ),
                        ).then((value) {
                          setState(() {
                            categoryList[index] = value;
                            calculateTotalExpense();
                          });
                        });
                      },
                      child: ExpenseCard(
                        categoryList: categoryList,
                        index: index,
                      ),
                    ),
                  );
                },
                itemCount: categoryList.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                    addCategoryDialog(context).then((value) {
                      if (value != null) {
                        setState(() {
                          categoryList.add(value);
                        });
                      }
                    });
                  },
                  color: Colors.white,
                  child: Text(
                    "Add Category",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
