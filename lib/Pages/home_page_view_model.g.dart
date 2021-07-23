// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModel, Store {
  final _$totalBudgetAtom = Atom(name: '_HomePageViewModel.totalBudget');

  @override
  int get totalBudget {
    _$totalBudgetAtom.reportRead();
    return super.totalBudget;
  }

  @override
  set totalBudget(int value) {
    _$totalBudgetAtom.reportWrite(value, super.totalBudget, () {
      super.totalBudget = value;
    });
  }

  final _$totalExpenseAtom = Atom(name: '_HomePageViewModel.totalExpense');

  @override
  double get totalExpense {
    _$totalExpenseAtom.reportRead();
    return super.totalExpense;
  }

  @override
  set totalExpense(double value) {
    _$totalExpenseAtom.reportWrite(value, super.totalExpense, () {
      super.totalExpense = value;
    });
  }

  final _$moneyLeftAtom = Atom(name: '_HomePageViewModel.moneyLeft');

  @override
  double get moneyLeft {
    _$moneyLeftAtom.reportRead();
    return super.moneyLeft;
  }

  @override
  set moneyLeft(double value) {
    _$moneyLeftAtom.reportWrite(value, super.moneyLeft, () {
      super.moneyLeft = value;
    });
  }

  final _$isLoadingDataAtom = Atom(name: '_HomePageViewModel.isLoadingData');

  @override
  bool get isLoadingData {
    _$isLoadingDataAtom.reportRead();
    return super.isLoadingData;
  }

  @override
  set isLoadingData(bool value) {
    _$isLoadingDataAtom.reportWrite(value, super.isLoadingData, () {
      super.isLoadingData = value;
    });
  }

  final _$categoryListAtom = Atom(name: '_HomePageViewModel.categoryList');

  @override
  List<ExpenseCategory> get categoryList {
    _$categoryListAtom.reportRead();
    return super.categoryList;
  }

  @override
  set categoryList(List<ExpenseCategory> value) {
    _$categoryListAtom.reportWrite(value, super.categoryList, () {
      super.categoryList = value;
    });
  }

  final _$loadSharedPrefsAsyncAction =
      AsyncAction('_HomePageViewModel.loadSharedPrefs');

  @override
  Future<dynamic> loadSharedPrefs() {
    return _$loadSharedPrefsAsyncAction.run(() => super.loadSharedPrefs());
  }

  final _$_HomePageViewModelActionController =
      ActionController(name: '_HomePageViewModel');

  @override
  void deleteCategory(int index) {
    final _$actionInfo = _$_HomePageViewModelActionController.startAction(
        name: '_HomePageViewModel.deleteCategory');
    try {
      return super.deleteCategory(index);
    } finally {
      _$_HomePageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalExpense() {
    final _$actionInfo = _$_HomePageViewModelActionController.startAction(
        name: '_HomePageViewModel.calculateTotalExpense');
    try {
      return super.calculateTotalExpense();
    } finally {
      _$_HomePageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMenuPageAndDetailPageReturn(List<ExpenseCategory> returnValue) {
    final _$actionInfo = _$_HomePageViewModelActionController.startAction(
        name: '_HomePageViewModel.setMenuPageAndDetailPageReturn');
    try {
      return super.setMenuPageAndDetailPageReturn(returnValue);
    } finally {
      _$_HomePageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChangeCategoryNameDialogReturn(dynamic returnValue, int index) {
    final _$actionInfo = _$_HomePageViewModelActionController.startAction(
        name: '_HomePageViewModel.setChangeCategoryNameDialogReturn');
    try {
      return super.setChangeCategoryNameDialogReturn(returnValue, index);
    } finally {
      _$_HomePageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddCategoryDialogReturn(dynamic returnValue) {
    final _$actionInfo = _$_HomePageViewModelActionController.startAction(
        name: '_HomePageViewModel.setAddCategoryDialogReturn');
    try {
      return super.setAddCategoryDialogReturn(returnValue);
    } finally {
      _$_HomePageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChangeBudgetDialogReturn(dynamic returnValue) {
    final _$actionInfo = _$_HomePageViewModelActionController.startAction(
        name: '_HomePageViewModel.setChangeBudgetDialogReturn');
    try {
      return super.setChangeBudgetDialogReturn(returnValue);
    } finally {
      _$_HomePageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalBudget: ${totalBudget},
totalExpense: ${totalExpense},
moneyLeft: ${moneyLeft},
isLoadingData: ${isLoadingData},
categoryList: ${categoryList}
    ''';
  }
}
