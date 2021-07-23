import 'package:beyond_helpers/beyond_helpers.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

import 'package:budget_planner/classes/expense_category.dart';
import 'package:budget_planner/models/shared_pref.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModel with _$HomePageViewModel;

abstract class _HomePageViewModel extends ViewModel with Store {
  final SharedPref sharedPref = SharedPref();
  final AsyncMemoizer memo = AsyncMemoizer();

  @observable
  int totalBudget = 0;

  @observable
  double totalExpense = 0;

  @observable
  double moneyLeft = 0;

  @observable
  bool isLoadingData = false;

  @observable
  List<ExpenseCategory> categoryList = [];

  // All TextEditingControllers
  final budgetTextEditingController = TextEditingController();
  final newCategoryTextEditingController = TextEditingController();
  final changeCategoryNameTextEditingController = TextEditingController();

  // Default Categories
  final ExpenseCategory housing = ExpenseCategory("Housing", 0, []);
  final ExpenseCategory groceries = ExpenseCategory("Groceries", 0, []);
  final ExpenseCategory bills = ExpenseCategory("Bills", 0, []);
  final ExpenseCategory entertainment = ExpenseCategory("Entertainment", 0, []);
  final ExpenseCategory clothing = ExpenseCategory("Clothing", 0, []);

  _HomePageViewModel() {
    loadSharedPrefs();
  }

  @action
  void deleteCategory(int index) {
    categoryList.removeAt(index);
    categoryList = List.from(categoryList);
    calculateTotalExpense();
    sharedPref.save("data", categoryList);
  }

  @action
  void calculateTotalExpense() {
    totalExpense = 0;
    for (int i = 0; i < categoryList.length; i++) {
      totalExpense += categoryList[i].expense;
    }
    moneyLeft = totalBudget.toDouble() - totalExpense;
  }

  @action
  Future loadSharedPrefs() async {
    isLoadingData = true;
    return memo.runOnce(() async {
      try {
        var json = await sharedPref.read("data");
        var tempList = <ExpenseCategory>[];
        for (int i = 0; i < json.length; i++) {
          ExpenseCategory e = ExpenseCategory.fromJson(json[i]);
          tempList.add(e);
        }
        categoryList = tempList;

        var budget = await sharedPref.read("budget");
        totalBudget = budget;
        calculateTotalExpense();
        isLoadingData = false;
      } catch (Excepetion) {
        print(Excepetion.toString());
        categoryList.add(housing);
        categoryList.add(groceries);
        categoryList.add(bills);
        categoryList.add(entertainment);
        categoryList.add(clothing);
        sharedPref.save("data", categoryList);
        sharedPref.saveNum("budget", 0);
        totalBudget = 0;
        moneyLeft = totalBudget.toDouble();
        isLoadingData = false;
      }
    });
  }

  @action
  void setMenuPageAndDetailPageReturn(List<ExpenseCategory> returnValue) {
    categoryList = returnValue;
    calculateTotalExpense();
  }

  @action
  void setChangeCategoryNameDialogReturn(dynamic returnValue, int index) {
    if (returnValue != null) {
      categoryList[index].name = returnValue as String;
      categoryList = List.from(categoryList);
      sharedPref.save("data", categoryList);
    }
  }

  @action
  void setAddCategoryDialogReturn(dynamic returnValue) {
    newCategoryTextEditingController.clear();
    if (returnValue != null) {
      categoryList.add(returnValue as ExpenseCategory);
      categoryList = List.from(categoryList);
      sharedPref.save("data", categoryList);
    }
  }

  @action
  void setChangeBudgetDialogReturn(dynamic returnValue) {
    budgetTextEditingController.clear();
    if (returnValue != null) {
      totalBudget = int.parse(returnValue);
      moneyLeft = totalBudget.toDouble() - totalExpense;
      sharedPref.saveNum("budget", totalBudget);
    }
  }

  Icon getIcon(int index) {
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

  Color getColor(int index) {
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

  // Region for methods that handling dialog return values
  // Region start
  // ------------------------
  String modifyBudgetDialogReturn() {
    return budgetTextEditingController.text;
  }

  ExpenseCategory newCategoryDialogReturn() {
    return ExpenseCategory(newCategoryTextEditingController.text, 0, []);
  }

  String chaneNameDialogReturn() {
    return changeCategoryNameTextEditingController.text;
  }
  // Region end
  // ------------------------
}
