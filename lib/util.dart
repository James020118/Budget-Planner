import 'package:flutter/material.dart';

class Util {
  static Icon getIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.hotel);
      case 1:
        return Icon(Icons.fastfood);
      case 2:
        return Icon(Icons.credit_card);
      case 3:
        return Icon(Icons.movie);
      case 4:
        return Icon(Icons.shopping_basket);
      default:
        return Icon(Icons.star);
    }
  }

  static Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.purple;
      case 2:
        return Colors.teal;
      case 3:
        return Colors.green;
      case 4:
        return Colors.yellow;
      default:
        return Colors.lightBlue;
    }
  }
}
