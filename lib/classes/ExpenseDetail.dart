import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ExpenseDetail {
  String title;
  double amount;
  DateTime t;
  String description;

  ExpenseDetail({this.title, this.amount, this.t, this.description});

  ExpenseDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    t = json['t'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        't': t,
        'description': description,
      };
}
