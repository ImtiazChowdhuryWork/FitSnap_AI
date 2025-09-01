import 'package:flutter/material.dart';

class ExploreWorkoutCategoriesProvider extends ChangeNotifier {
  int? _selectedCategoryId; // store the selected category id

  int? get selectedCategoryId => _selectedCategoryId;

  // call this when a category is tapped
  void updateSelectedCategory({required int id}) {
    if (_selectedCategoryId == id) {
      // unselect if tapped again
      _selectedCategoryId = null;
    } else {
      _selectedCategoryId = id;
    }
    notifyListeners();
  }

  bool isCategorySelected(int id) {
    return _selectedCategoryId == id;
  }
}
