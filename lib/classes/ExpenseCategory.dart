import 'package:flutter/material.dart';
import 'package:budget_planner/classes/ExpenseDetail.dart';

class ExpenseCategory {
  String name;
  double expense;
  Color categoryColor;
  IconData categoryIcon;
  List<ExpenseDetail> dets;

  ExpenseCategory(
      String n, double e, Color c, IconData i, List<ExpenseDetail> d) {
    this.name = n;
    this.expense = e;
    this.categoryColor = c;
    this.categoryIcon = i;
    this.dets = d;
  }

  void addExpense(double amount) {
    expense += amount;
  }

  void addDetail(ExpenseDetail d) {
    dets.add(d);
    expense += d.amount;
  }

  void removeDetail(int index) {
    expense -= dets[index].amount;
    dets.removeAt(index);
  }
}
