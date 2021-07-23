import 'package:flutter/material.dart';

import 'Pages/home_page.dart';
import 'package:budget_planner/Pages/home_page_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Avenir Next Rounded"),
      home: HomePage(HomePageViewModel()),
    );
  }
}
