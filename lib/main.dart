import 'dart:convert';
import 'dart:io';
import 'Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'classes/ExpenseCategory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Avenir Next Rounded"),
      home: HomePage(
        storage: LocalStorage(),
      ),
    );
  }
}

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<List<ExpenseCategory>> readData() async {
    try {
      final file = await _localFile;
      // TODO: Read the file

    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeData(List<ExpenseCategory> l) async {
    final file = await _localFile;
    final encodedList = jsonEncode(l);
    return file.writeAsString(encodedList);
  }
}
