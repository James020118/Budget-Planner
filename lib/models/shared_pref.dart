import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:budget_planner/classes/expense_category.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? '');
  }

  save(String key, List<ExpenseCategory> value) async {
    final prefs = await SharedPreferences.getInstance();
    var data = jsonEncode(value.map((e) => e.toJson()).toList());
    prefs.setString(key, data);
  }

  saveNum(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
