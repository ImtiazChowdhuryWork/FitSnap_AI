class MealPlanModel {
  bool? success;
  String? message;
  MealPlanData? data;

  MealPlanModel({
    this.success,
    this.message,
    this.data,
  });

  factory MealPlanModel.fromJson(Map<String, dynamic> json) => MealPlanModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : MealPlanData.fromJson((json["data"].runtimeType == Map<String, dynamic>) ? json["data"] : {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class MealPlanData {
  String? goal;
  String? calories;
  MacrosInfo? macrosInfo;
  List<MealItem>? meals;
  HydrationInfo? hydrationInfo;
  SwapsInfo? swapsInfo;
  String? notes;

  MealPlanData({
    this.goal,
    this.calories,
    this.macrosInfo,
    this.meals,
    this.hydrationInfo,
    this.swapsInfo,
    this.notes,
  });

  factory MealPlanData.fromJson(Map<String, dynamic> json) => MealPlanData(
        goal: json["goal"],
        calories: json["calories"],
        macrosInfo: json["macros_info"] == null
            ? null
            : MacrosInfo.fromJson(json["macros_info"]),
        meals: json["meals"] == null
            ? []
            : List<MealItem>.from(
                json["meals"]!.map((x) => MealItem.fromJson(x))),
        hydrationInfo: json["hydration_info"] == null
            ? null
            : HydrationInfo.fromJson(json["hydration_info"]),
        swapsInfo: json["swaps_info"] == null
            ? null
            : SwapsInfo.fromJson(json["swaps_info"]),
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "goal": goal,
        "calories": calories,
        "macros_info": macrosInfo?.toJson(),
        "meals": meals == null
            ? []
            : List<dynamic>.from(meals!.map((x) => x.toJson())),
        "hydration_info": hydrationInfo?.toJson(),
        "swaps_info": swapsInfo?.toJson(),
        "notes": notes,
      };

  /// Get formatted goal without emoji for display - with comprehensive emoji removal
  String get cleanGoal {
    if (goal == null) return "";
    return _cleanTextSafely(goal!)
        .replaceAll(RegExp(r'Goal:\s*', caseSensitive: false), '');
  }

  /// Get formatted calories without emoji for display - with comprehensive emoji removal
  String get cleanCalories {
    if (calories == null) return "";
    return _cleanTextSafely(calories!)
        .replaceAll(RegExp(r'Calories:\s*', caseSensitive: false), '');
  }

  /// Get formatted notes without emoji for display - with comprehensive emoji removal
  String get cleanNotes {
    if (notes == null) return "";
    return _cleanTextSafely(notes!)
        .replaceAll(RegExp(r'Notes:\s*', caseSensitive: false), '');
  }

  /// Get total meals count
  int get totalMeals => meals?.length ?? 0;

  /// Safe emoji removal method with comprehensive patterns
  String _cleanTextSafely(String text) {
    return text
        // Remove emoji ranges
        .replaceAll(RegExp(r'[\u{1F300}-\u{1F9FF}]', unicode: true), '') // Misc Symbols and Pictographs
        .replaceAll(RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true), '') // Emoticons
        .replaceAll(RegExp(r'[\u{1F680}-\u{1F6FF}]', unicode: true), '') // Transport and Map
        .replaceAll(RegExp(r'[\u{1F1E0}-\u{1F1FF}]', unicode: true), '') // Regional Indicators (Flags)
        .replaceAll(RegExp(r'[\u{2600}-\u{26FF}]', unicode: true), '') // Miscellaneous Symbols
        .replaceAll(RegExp(r'[\u{2700}-\u{27BF}]', unicode: true), '') // Dingbats
        .replaceAll(RegExp(r'[\u{FE00}-\u{FE0F}]', unicode: true), '') // Variation Selectors
        .replaceAll(RegExp(r'[\u{200D}]', unicode: true), '') // Zero Width Joiner
        .replaceAll(RegExp(r'[\u{20E3}]', unicode: true), '') // Combining Enclosing Keycap
        // Clean up whitespace
        .replaceAll(RegExp(r'[\s]+'), ' ')
        .trim();
  }
}

class MacrosInfo {
  String? protein;
  String? carbs;
  String? fat;
  String? fiber;

  MacrosInfo({
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
  });

  factory MacrosInfo.fromJson(Map<String, dynamic> json) => MacrosInfo(
        protein: json["protein"],
        carbs: json["carbs"],
        fat: json["fat"],
        fiber: json["fiber"],
      );

  Map<String, dynamic> toJson() => {
        "protein": protein,
        "carbs": carbs,
        "fat": fat,
        "fiber": fiber,
      };

  /// Get clean protein value without emoji - with comprehensive emoji removal
  String get cleanProtein => _cleanMacroTextSafely(protein ?? "");

  /// Get clean carbs value without emoji - with comprehensive emoji removal
  String get cleanCarbs => _cleanMacroTextSafely(carbs ?? "");

  /// Get clean fat value without emoji - with comprehensive emoji removal
  String get cleanFat => _cleanMacroTextSafely(fat ?? "");

  /// Get clean fiber value without emoji - with comprehensive emoji removal
  String get cleanFiber => _cleanMacroTextSafely(fiber ?? "");

  /// Safe macro text cleaning with comprehensive emoji removal
  String _cleanMacroTextSafely(String text) {
    return text
        // Remove emoji ranges
        .replaceAll(RegExp(r'[\u{1F300}-\u{1F9FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F680}-\u{1F6FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2600}-\u{26FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2700}-\u{27BF}]', unicode: true), '')
        // Clean up whitespace
        .replaceAll(RegExp(r'[\s]+'), ' ')
        .trim();
  }
}

class MealItem {
  String? meal;
  String? items;
  String? approxKcal;
  String? proteinG;

  MealItem({
    this.meal,
    this.items,
    this.approxKcal,
    this.proteinG,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) => MealItem(
        meal: json["meal"],
        items: json["items"],
        approxKcal: json["approx_kcal"],
        proteinG: json["protein_g"],
      );

  Map<String, dynamic> toJson() => {
        "meal": meal,
        "items": items,
        "approx_kcal": approxKcal,
        "protein_g": proteinG,
      };

  /// Extract meal type from meal description (e.g., "Breakfast", "Lunch")
  String get mealType {
    if (meal == null) return "Meal";
    
    // Clean text first, then extract type
    String cleanedMeal = _cleanTextSafely(meal!);
    
    // Try to find type after cleaning
    final parts = cleanedMeal.split(':');
    if (parts.isNotEmpty) {
      String type = parts.first.trim();
      if (type.isNotEmpty) return type;
    }
    
    // Fallback based on keywords
    final mealLower = cleanedMeal.toLowerCase();
    if (mealLower.contains('breakfast')) return 'Breakfast';
    if (mealLower.contains('lunch')) return 'Lunch';
    if (mealLower.contains('dinner')) return 'Dinner';
    if (mealLower.contains('snack')) return 'Snack';
    if (mealLower.contains('workout')) return 'Post-workout';
    if (mealLower.contains('morning')) return 'Mid-morning';
    
    return "Meal";
  }

  /// Extract meal description without emoji and type - with comprehensive emoji removal
  String get cleanDescription {
    if (meal == null) return "";
    
    String cleanedMeal = _cleanTextSafely(meal!);
    
    final parts = cleanedMeal.split(':');
    if (parts.length > 1) {
      return parts.sublist(1).join(':').trim();
    }
    
    return cleanedMeal;
  }

  /// Get safe emoji for meal type with device compatibility
  String get mealEmoji {
    if (meal == null) return "🍽️";
    
    // Safe emoji fallbacks for different platforms
    final mealTypeLower = mealType.toLowerCase();
    
    // Use simple, well-supported emojis
    if (mealTypeLower.contains('breakfast')) return '🍳'; // Cooking/egg - widely supported
    if (mealTypeLower.contains('lunch')) return '🥗'; // Salad - widely supported  
    if (mealTypeLower.contains('dinner')) return '🍽️'; // Plate - very basic
    if (mealTypeLower.contains('snack')) return '🍎'; // Apple - very basic
    if (mealTypeLower.contains('workout') || mealTypeLower.contains('post')) return '💪'; // Muscle - basic
    if (mealTypeLower.contains('morning')) return '☕'; // Coffee - very basic
    
    return '🍽️'; // Most basic plate emoji as ultimate fallback
  }

  /// Get formatted calories
  String get formattedCalories => items ?? "0 kcal";

  /// Get formatted protein
  String get formattedProtein => approxKcal ?? "0g";

  /// Safe text cleaning method
  String _cleanTextSafely(String text) {
    return text
        // Remove emoji ranges comprehensively
        .replaceAll(RegExp(r'[\u{1F300}-\u{1F9FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F680}-\u{1F6FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F1E0}-\u{1F1FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2600}-\u{26FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2700}-\u{27BF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{FE00}-\u{FE0F}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{200D}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{20E3}]', unicode: true), '')
        // Clean whitespace
        .replaceAll(RegExp(r'[\s]+'), ' ')
        .trim();
  }
}

class SwapsInfo {
  String? vegetarian;
  String? easyOptions;

  SwapsInfo({
    this.vegetarian,
    this.easyOptions,
  });

  factory SwapsInfo.fromJson(Map<String, dynamic> json) => SwapsInfo(
        vegetarian: json["vegetarian"],
        easyOptions: json["easy_options"],
      );

  Map<String, dynamic> toJson() => {
        "vegetarian": vegetarian,
        "easy_options": easyOptions,
      };

  /// Get clean vegetarian options without emoji - with comprehensive emoji removal
  String get cleanVegetarian {
    if (vegetarian == null) return "";
    return _cleanTextSafely(vegetarian!)
        .replaceAll(RegExp(r'Vegetarian:\s*', caseSensitive: false), '');
  }

  /// Get clean easy options without emoji - with comprehensive emoji removal
  String get cleanEasyOptions {
    if (easyOptions == null) return "";
    return _cleanTextSafely(easyOptions!)
        .replaceAll(RegExp(r'Easy_options:\s*', caseSensitive: false), '');
  }

  /// Safe text cleaning method
  String _cleanTextSafely(String text) {
    return text
        .replaceAll(RegExp(r'[\u{1F300}-\u{1F9FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F680}-\u{1F6FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2600}-\u{26FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2700}-\u{27BF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\s]+'), ' ')
        .trim();
  }
}

class HydrationInfo {
  String? hydration;

  HydrationInfo({
    this.hydration,
  });

  factory HydrationInfo.fromJson(Map<String, dynamic> json) => HydrationInfo(
        hydration: json["hydration"],
      );

  Map<String, dynamic> toJson() => {
        "hydration": hydration,
      };

  /// Get clean hydration info without emoji - with comprehensive emoji removal
  String get cleanHydration {
    if (hydration == null) return "";
    return _cleanTextSafely(hydration!)
        .replaceAll(RegExp(r'Water\s*', caseSensitive: false), '');
  }

  /// Safe text cleaning method
  String _cleanTextSafely(String text) {
    return text
        .replaceAll(RegExp(r'[\u{1F300}-\u{1F9FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{1F680}-\u{1F6FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2600}-\u{26FF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\u{2700}-\u{27BF}]', unicode: true), '')
        .replaceAll(RegExp(r'[\s]+'), ' ')
        .trim();
  }
}