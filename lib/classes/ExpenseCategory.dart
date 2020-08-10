import 'package:budget_planner/classes/ExpenseDetail.dart';

class ExpenseCategory {
  String name;
  double expense;
  List<ExpenseDetail> dets;

  ExpenseCategory(String n, double e, List<ExpenseDetail> d) {
    this.name = n;
    this.expense = e;
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
