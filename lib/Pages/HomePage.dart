import 'package:budget_planner/ExpenseCategory.dart';
import 'package:budget_planner/ExpenseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ExpenseDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalBudget = 0;
  int totalExpense = 0;

  ExpenseCategory housing =
      ExpenseCategory("Housing", 0, Colors.orange, Icons.hotel);
  ExpenseCategory food =
      ExpenseCategory("Food", 0, Colors.purple, Icons.fastfood);
  ExpenseCategory bills =
      ExpenseCategory("Bills", 0, Colors.green, Icons.credit_card);
  ExpenseCategory entertainment =
      ExpenseCategory("Entertainment", 0, Colors.lightBlue, Icons.local_play);
  ExpenseCategory clothing =
      ExpenseCategory("Clothing", 0, Colors.teal, Icons.shopping_basket);
  List<ExpenseCategory> categoryList = [];

  @override
  void initState() {
    super.initState();
    categoryList.add(housing);
    categoryList.add(food);
    categoryList.add(bills);
    categoryList.add(entertainment);
    categoryList.add(clothing);
    for (int i = 0; i < categoryList.length; i++) {
      totalExpense += categoryList[i].expense;
    }
  }

  Future<int> createBudgetDialog(BuildContext context) {
    TextEditingController myController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 210,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Enter New Budget",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextField(
                              controller: myController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Budget",
                                hintText: "Numbers Only",
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            if (myController.text.isNotEmpty) {
                              Navigator.of(context)
                                  .pop(int.parse(myController.text.toString()));
                            }
                          },
                          color: Colors.white,
                          child: Text(
                            "Modify",
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
                          color: Colors.white,
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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                "Total Expenses:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "\$$totalExpense / \$$totalBudget",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpenseDetailPage(
                                    expense: categoryList[index],
                                  ),
                                ),
                              );
                            },
                            child: ExpenseCard(
                              categoryList: categoryList,
                              index: index,
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
                          onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
