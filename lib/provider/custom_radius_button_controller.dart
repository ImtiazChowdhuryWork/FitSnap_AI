import 'package:flutter/material.dart';

class CustomRadiusButtonController extends ChangeNotifier {
  int _selectedIndex = -1; // -1 means nothing selected

  int get selectedIndex => _selectedIndex;

  /// Set selected index
  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Check if the given index is selected
  bool isSelected(int index) => _selectedIndex == index;
}
