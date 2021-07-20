import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExpenseDetail {
  late String title;
  late double amount;
  late DateTime t;
  late String description;

  ExpenseDetail({
    required this.title,
    required this.amount,
    required this.t,
    required this.description,
  });

  ExpenseDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    t = DateTime.parse(json['t'].toString());
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        't': t.toIso8601String(),
        'description': description,
      };
}
