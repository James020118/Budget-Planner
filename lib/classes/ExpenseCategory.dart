import 'package:budget_planner/classes/ExpenseDetail.dart';

class ExpenseCategory {
  late String name;
  late double expense;
  late List<ExpenseDetail> dets;

  ExpenseCategory(String name, double expense, List<ExpenseDetail> dets) {
    this.name = name;
    this.expense = expense;
    this.dets = dets;
  }

  void addExpense(double amount) {
    expense += amount;
  }

  void addDetail(ExpenseDetail detail) {
    dets.add(detail);
    expense += detail.amount;
  }

  void removeDetail(int index) {
    expense -= dets[index].amount;
    dets.removeAt(index);
  }

  ExpenseCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    expense = json['expense'];
    // print(json['dets']);
    var temp = [];
    for (int i = 0; i < json['dets'].length; i++) {
      ExpenseDetail ed = ExpenseDetail.fromJson(json['dets'][i]);
      temp.add(ed);
    }
    dets = temp.cast<ExpenseDetail>();
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'expense': expense,
        'dets': dets,
      };
}
