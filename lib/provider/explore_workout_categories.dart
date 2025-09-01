import 'package:flutter/material.dart';

class ExploreWorkoutCategoriesProvider extends ChangeNotifier {
  int? _selectedCategoryId;

  int? get selectedCategoryId => _selectedCategoryId;

  void updateSelectedCategory({required int id}) {
    if (_selectedCategoryId == id) {
      _selectedCategoryId = null; // unselect if tapped again
    } else {
      _selectedCategoryId = id;
    }
    notifyListeners();
  }

  bool isCategorySelected(int id) {
    return _selectedCategoryId == id;
  }
}
