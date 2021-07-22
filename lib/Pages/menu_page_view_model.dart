import 'package:beyond_helpers/beyond_helpers.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:budget_planner/classes/expense_category.dart';
import 'package:budget_planner/models/shared_pref.dart';

part 'menu_page_view_model.g.dart';

class MenuPageViewModel = _MenuPageViewModel with _$MenuPageViewModel;

abstract class _MenuPageViewModel extends ViewModel with Store {
  final sharedPref = SharedPref();

  List<ExpenseCategory> allExpenseCategories;

  _MenuPageViewModel({
    required this.allExpenseCategories,
  });

  void clearCategoriesAndPop(BuildContext context) {
    for (int i = 0; i < allExpenseCategories.length; i++) {
      allExpenseCategories[i].dets.clear();
      allExpenseCategories[i].expense = 0;
    }
    sharedPref.save("data", allExpenseCategories);
    Navigator.of(context).pop();
  }
}
