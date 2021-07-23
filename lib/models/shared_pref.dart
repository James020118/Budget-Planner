import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:budget_planner/classes/expense_category.dart';

class SharedPref {
  dynamic read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? '');
  }

  Future<void> save(String key, List<ExpenseCategory> value) async {
    final prefs = await SharedPreferences.getInstance();
    var data = jsonEncode(value.map((e) => e.toJson()).toList());
    await prefs.setString(key, data);
  }

  Future<void> saveNum(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
