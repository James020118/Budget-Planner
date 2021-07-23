// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailPageViewModel on _DetailPageViewModel, Store {
  final _$selectedCategoryAtom =
      Atom(name: '_DetailPageViewModel.selectedCategory');

  @override
  ExpenseCategory get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(ExpenseCategory value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$_DetailPageViewModelActionController =
      ActionController(name: '_DetailPageViewModel');

  @override
  void addTransaction(ExpenseDetail newDetail) {
    final _$actionInfo = _$_DetailPageViewModelActionController.startAction(
        name: '_DetailPageViewModel.addTransaction');
    try {
      return super.addTransaction(newDetail);
    } finally {
      _$_DetailPageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTransaction(int removedIndex) {
    final _$actionInfo = _$_DetailPageViewModelActionController.startAction(
        name: '_DetailPageViewModel.removeTransaction');
    try {
      return super.removeTransaction(removedIndex);
    } finally {
      _$_DetailPageViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategory: ${selectedCategory}
    ''';
  }
}
