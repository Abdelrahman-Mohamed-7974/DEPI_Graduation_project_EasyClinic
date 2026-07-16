import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedDayIndex =
      2; // Selected Wednesday by default to match screenshot

  int get selectedDayIndex => _selectedDayIndex;

  void selectDay(int index) {
    _selectedDayIndex = index;
    notifyListeners();
  }
}
