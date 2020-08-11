import 'dart:convert';
import 'Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'classes/ExpenseCategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Avenir Next Rounded"),
      home: HomePage(),
    );
  }
}

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
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
