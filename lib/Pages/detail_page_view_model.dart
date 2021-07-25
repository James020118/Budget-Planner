import 'package:beyond_helpers/beyond_helpers.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import 'package:budget_planner/classes/expense_category.dart';
import 'package:budget_planner/classes/expense_detail.dart';
import 'package:budget_planner/classes/shared_pref.dart';

part 'detail_page_view_model.g.dart';

class DetailPageViewModel = _DetailPageViewModel with _$DetailPageViewModel;

abstract class _DetailPageViewModel extends ViewModel with Store {
  final List<ExpenseCategory> allExpense;
  final int index;
  final Icon titleIcon;
  final Color titleColor;

  final sharedPref = SharedPref();

  @observable
  ExpenseCategory selectedCategory;

  _DetailPageViewModel({
    required this.allExpense,
    required this.index,
    required this.selectedCategory,
    required this.titleIcon,
    required this.titleColor,
  });

  @action
  void addTransaction(ExpenseDetail newDetail) {
    selectedCategory.addDetail(newDetail);
    selectedCategory = ExpenseCategory(
      selectedCategory.name,
      selectedCategory.expense,
      selectedCategory.dets,
    );
    allExpense[index] = selectedCategory;
    sharedPref.save('data', allExpense);
  }

  @action
  void removeTransaction(int removedIndex) {
    selectedCategory.removeDetail(removedIndex);
    selectedCategory = ExpenseCategory(
      selectedCategory.name,
      selectedCategory.expense,
      selectedCategory.dets,
    );
    allExpense[index] = selectedCategory;
    sharedPref.save('data', allExpense);
  }
}
