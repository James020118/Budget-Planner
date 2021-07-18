import 'package:flutter/material.dart';

import '../classes/ExpenseCategory.dart';

class ExpenseCard extends StatefulWidget {
  late final List<ExpenseCategory> categoryList;
  late final int index;

  ExpenseCard({
    required this.categoryList,
    required this.index,
  });

  @override
  _ExpenseCardState createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  Icon _getIcon() {
    if (widget.index == 0) {
      return Icon(Icons.hotel);
    } else if (widget.index == 1) {
      return Icon(Icons.fastfood);
    } else if (widget.index == 2) {
      return Icon(Icons.credit_card);
    } else if (widget.index == 3) {
      return Icon(Icons.movie);
    } else if (widget.index == 4) {
      return Icon(Icons.shopping_basket);
    } else {
      return Icon(Icons.star);
    }
  }

  Color _getColor() {
    if (widget.index == 0) {
      return Colors.orange;
    } else if (widget.index == 1) {
      return Colors.purple;
    } else if (widget.index == 2) {
      return Colors.teal;
    } else if (widget.index == 3) {
      return Colors.green;
    } else if (widget.index == 4) {
      return Colors.yellow;
    } else {
      return Colors.lightBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
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
                  color: _getColor(),
                  shape: BoxShape.circle,
                ),
                child: _getIcon(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                widget.categoryList[widget.index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Spent: \$${widget.categoryList[widget.index].expense.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white,
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
