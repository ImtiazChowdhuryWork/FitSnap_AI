// import 'package:flutter/material.dart';

//Refarence : Without All category & currently onselected category videos are not showing
// class ExploreWorkoutCategoriesProvider extends ChangeNotifier {
//   int? _selectedCategoryId;

//   int? get selectedCategoryId => _selectedCategoryId;

//   void updateSelectedCategory({required int id}) {
//     if (_selectedCategoryId == id) {
//       _selectedCategoryId = null; // unselect if tapped again
//     } else {
//       _selectedCategoryId = id;
//     }
//     notifyListeners();
//   }

//   bool isCategorySelected(int id) {
//     return _selectedCategoryId == id;
//   }
// }

// import 'package:flutter/material.dart';

// class ExploreWorkoutCategoriesProvider extends ChangeNotifier {
//   int? _selectedCategoryId = -1; // default to "(All)"

//   int? get selectedCategoryId => _selectedCategoryId;

//   void updateSelectedCategory({required int id}) {
//     if (_selectedCategoryId == id) {
//       _selectedCategoryId = null; // unselect if tapped again
//     } else {
//       _selectedCategoryId = id;
//     }
//     notifyListeners();
//   }

//   bool isCategorySelected(int id) {
//     return _selectedCategoryId == id;
//   }
// }

// import 'package:flutter/material.dart';

// class ExploreWorkoutCategoriesProvider extends ChangeNotifier {
//   int _selectedCategoryId = -1; // default to "(All)"

//   int get selectedCategoryId => _selectedCategoryId;

//   void updateSelectedCategory({required int id}) {
//     _selectedCategoryId = id; // always set directly
//     notifyListeners();
//   }

//   bool isCategorySelected(int id) {
//     return _selectedCategoryId == id;
//   }
// }

import 'package:flutter/material.dart';

class ExploreWorkoutCategoriesProvider extends ChangeNotifier {
  int _selectedCategoryId = -1; // default to "(All)"

  int get selectedCategoryId => _selectedCategoryId;

  void updateSelectedCategory({required int id}) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  bool isCategorySelected(int id) {
    return _selectedCategoryId == id;
  }
}
