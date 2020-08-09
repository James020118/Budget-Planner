import 'package:flutter/material.dart';
import 'package:budget_planner/classes/ExpenseCategory.dart';

Future<ExpenseCategory> addCategoryDialog(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  List<bool> _selected = [true, false, false, false, false];
  List<Color> colors = [
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.teal
  ];
  int selectedIndex = 0;
  selectColor(int number) {
    for (int i = 0; i < _selected.length; i++) {
      _selected[i] = false;
    }
    _selected[number] = true;
    selectedIndex = number;
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "New Category",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: "Category Name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _selected[0]
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Center(
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: colors[0],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              selectColor(0);
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _selected[1]
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Center(
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: colors[1],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              selectColor(1);
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _selected[2]
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Center(
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: colors[2],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              selectColor(2);
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _selected[3]
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Center(
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: colors[3],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              selectColor(3);
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _selected[4]
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Center(
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: colors[4],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              selectColor(4);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue),
                          ),
                          onPressed: () {
                            if (nameController.text.isNotEmpty) {
                              String name = nameController.text;
                              ExpenseCategory ec = ExpenseCategory(name, 0,
                                  colors[selectedIndex], Icons.star, []);
                              Navigator.of(context).pop(ec);
                            }
                          },
                          color: Colors.white,
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.white,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}