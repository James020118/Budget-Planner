import 'package:flutter/material.dart';

class ExpenseCategory {
  String name;
  int expense;
  Color categoryColor;
  IconData categoryIcon;

  ExpenseCategory(String n, int e, Color c, IconData i) {
    this.name = n;
    this.expense = e;
    this.categoryColor = c;
    this.categoryIcon = i;
  }

  void addExpense(int amount) {
    expense += amount;
  }
}
