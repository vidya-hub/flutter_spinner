import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SpinProvider extends ChangeNotifier {
  bool isAnimating = false;
  String? selectedValue;

  List<Map<String, dynamic>> rollValues = [
    {"value": '5% Cashback \n Groceries', "color": const Color(0xFF6495ED)},
    {"value": '10% Cashback \n Fuel', "color": const Color(0xFFD8BFD8)},
    {"value": '15% Cashback \n Dining', "color": const Color(0xFFDEB887)},
    {
      "value": '20% Cashback \n Travel Bookings',
      "color": const Color(0xFF4682B4)
    },
    {
      "value": '25% Cashback \n Movie Tickets',
      "color": const Color(0xFF00FA9A),
    },
    {
      "value": '30% Cashback \n Online Shopping',
      "color": const Color(0xFFFF69B4),
    },
    {
      "value": '5% Cashback \n Utility Bill Payments',
      "color": const Color(0xFFFFD700),
    },
    {
      "value": '10% Cashback \n Mobile Recharges',
      "color": const Color(0xFF20B2AA),
    },
    {"value": 'Better luck next time', "color": Colors.blueGrey},
  ];

  get giveRandomColor {
    return rollValues[Random().nextInt(rollValues.length)]["color"];
  }

  final StreamController<int> _spinStreamController =
      StreamController<int>.broadcast();
  Stream<int> get spinStream => _spinStreamController.stream;

  void roll() {
    int rollValue = Random().nextInt(rollValues.length);
    selectedValue = rollValues[rollValue]["value"];
    _spinStreamController.add(rollValue);
    notifyListeners();
  }

  void startAnimation() {
    isAnimating = true;
    notifyListeners();
  }

  void stopAnimation() {
    isAnimating = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _spinStreamController.close();
    super.dispose();
  }
}
