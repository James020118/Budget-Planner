import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:budget_planner/classes/expense_detail.dart';

class DetailCard extends StatefulWidget {
  late final List<ExpenseDetail> details;
  late final int index;

  DetailCard({
    required this.details,
    required this.index,
  });

  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  late String transactionTitle;
  late double transactionAmount;
  late DateTime transactionTime;
  late String transactionDescription;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    transactionTitle = widget.details[widget.index].title;
    transactionAmount = widget.details[widget.index].amount;
    transactionTime = widget.details[widget.index].t;
    formattedDate = DateFormat('yyyy-MM-dd').format(transactionTime);
    transactionDescription = widget.details[widget.index].description;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "$transactionTitle",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "\$${transactionAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "$formattedDate",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$transactionDescription",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
