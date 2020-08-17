import 'package:budget_planner/classes/ExpenseCategory.dart';
import 'package:budget_planner/main.dart';
import 'package:budget_planner/modules/ExpenseCard.dart';
import 'package:flutter/material.dart';
import 'ExpenseDetailPage.dart';
import 'package:budget_planner/modules/BudgetDialog.dart';
import 'package:budget_planner/modules/CategoryDialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:async/async.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPref sharedPref = SharedPref();
  int totalBudget = 0;
  double totalExpense = 0;

  // starting categories
  ExpenseCategory housing = ExpenseCategory("Housing", 0, []);
  ExpenseCategory food = ExpenseCategory("Food", 0, []);
  ExpenseCategory bills = ExpenseCategory("Bills", 0, []);
  ExpenseCategory entertainment = ExpenseCategory("Entertainment", 0, []);
  ExpenseCategory clothing = ExpenseCategory("Clothing", 0, []);
  List<ExpenseCategory> categoryList = [];

  calculateTotalExpense() {
    totalExpense = 0;
    for (int i = 0; i < categoryList.length; i++) {
      totalExpense += categoryList[i].expense;
    }
  }

  Icon _getIcon(int index) {
    if (index == 0) {
      return Icon(Icons.hotel);
    } else if (index == 1) {
      return Icon(Icons.fastfood);
    } else if (index == 2) {
      return Icon(Icons.credit_card);
    } else if (index == 3) {
      return Icon(Icons.movie);
    } else if (index == 4) {
      return Icon(Icons.shopping_basket);
    } else {
      return Icon(Icons.star);
    }
  }

  Color _getColor(int index) {
    if (index == 0) {
      return Colors.orange;
    } else if (index == 1) {
      return Colors.purple;
    } else if (index == 2) {
      return Colors.teal;
    } else if (index == 3) {
      return Colors.green;
    } else if (index == 4) {
      return Colors.yellow;
    } else {
      return Colors.lightBlue;
    }
  }

  _loadSharedPrefs() {
    return memo.runOnce(() async {
      try {
        var json = await sharedPref.read("data");
        for (int i = 0; i < json.length; i++) {
          ExpenseCategory e = ExpenseCategory.fromJson(json[i]);
          categoryList.add(e);
        }
        var budget = await sharedPref.read("budget");
        setState(() {
          totalBudget = budget;
          calculateTotalExpense();
        });
        return categoryList;
      } catch (Excepetion) {
        print(Excepetion.toString());
        categoryList.add(housing);
        categoryList.add(food);
        categoryList.add(bills);
        categoryList.add(entertainment);
        categoryList.add(clothing);
        sharedPref.save("data", categoryList);
        sharedPref.saveNum("budget", 0);
        setState(() {
          totalBudget = 0;
        });
        return categoryList;
      }
    });
  }

  final AsyncMemoizer memo = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    // sharedPref.remove("data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width / 9, height: 0.0),
                Text(
                  "BUDGET PLANNER",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Avenir Next Rounded',
                      ),
                      children: [
                        TextSpan(
                          text: " / \$$totalBudget",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
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
                    color: Colors.grey[800],
                    onPressed: () {
                      createBudgetDialog(context).then((value) {
                        setState(() {
                          if (value != null) {
                            totalBudget = value;
                            sharedPref.saveNum("budget", totalBudget);
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _loadSharedPrefs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
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
                                  sharedPref.save("data", categoryList);
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
                                    allExpense: categoryList,
                                    index: index,
                                    titleIcon: _getIcon(index),
                                    titleColor: _getColor(index),
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  categoryList = value;
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
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
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
                          sharedPref.save("data", categoryList);
                        });
                      }
                    });
                  },
                  color: Colors.grey[800],
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
