import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:budget_planner/classes/expense_category.dart';
import 'package:budget_planner/models/detail_card.dart';
import 'package:budget_planner/models/transaction_dialog.dart';
import 'package:budget_planner/models/shared_pref.dart';

class ExpenseDetailPage extends StatefulWidget {
  final List<ExpenseCategory> allExpense;
  final int index;
  final Icon titleIcon;
  final Color titleColor;

  ExpenseDetailPage({
    required this.allExpense,
    required this.index,
    required this.titleIcon,
    required this.titleColor,
  });

  @override
  _ExpenseDetailPageState createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(widget.allExpense);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
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
                      color: widget.titleColor,
                      shape: BoxShape.circle,
                    ),
                    child: widget.titleIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "${widget.allExpense[widget.index].name} \$${widget.allExpense[widget.index].expense.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
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
                onTap: () {
                  addTransactionDialog(context).then((value) {
                    if (value != null) {
                      setState(() {
                        widget.allExpense[widget.index].addDetail(value);
                        sharedPref.save("data", widget.allExpense);
                      });
                    }
                  });
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                          widget.allExpense[widget.index].removeDetail(index);
                          sharedPref.save("data", widget.allExpense);
                        });
                      },
                    ),
                  ],
                  child: GestureDetector(
                    child: DetailCard(
                      details: widget.allExpense[widget.index].dets,
                      index: index,
                    ),
                  ),
                );
              },
              itemCount: widget.allExpense[widget.index].dets.length,
            ),
          ),
        ],
      ),
    );
  }
}
