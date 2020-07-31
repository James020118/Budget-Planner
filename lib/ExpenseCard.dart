import 'ExpenseCategory.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatefulWidget {
  final List<ExpenseCategory> categoryList;
  final int index;

  ExpenseCard({@required this.categoryList, @required this.index});

  @override
  _ExpenseCardState createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.categoryList[widget.index].categoryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.categoryList[widget.index].categoryIcon),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                widget.categoryList[widget.index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Spent: \$${widget.categoryList[widget.index].expense}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
