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
        data: json["data"] == null ? null : MealPlanData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class MealPlanData {
  int? id;
  int? user;
  String? goal;
  String? calories;
  String? hydration;
  String? notes;
  MacrosInfo? macrosInfo;
  List<MealItem>? meals;
  SwapsInfo? swapsInfo;
  HydrationInfo? hydrationInfo;

  MealPlanData({
    this.id,
    this.user,
    this.goal,
    this.calories,
    this.hydration,
    this.notes,
    this.macrosInfo,
    this.meals,
    this.swapsInfo,
    this.hydrationInfo,
  });

  factory MealPlanData.fromJson(Map<String, dynamic> json) => MealPlanData(
        id: json["id"],
        user: json["user"],
        goal: json["goal"],
        calories: json["calories"],
        hydration: json["hydration"],
        notes: json["notes"],
        macrosInfo: json["macros_info"] == null
            ? null
            : MacrosInfo.fromJson(json["macros_info"]),
        meals: json["meals"] == null
            ? []
            : List<MealItem>.from(
                json["meals"]!.map((x) => MealItem.fromJson(x))),
        swapsInfo: json["swaps_info"] == null
            ? null
            : SwapsInfo.fromJson(json["swaps_info"]),
        hydrationInfo: json["hydration_info"] == null
            ? null
            : HydrationInfo.fromJson(json["hydration_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "goal": goal,
        "calories": calories,
        "hydration": hydration,
        "notes": notes,
        "macros_info": macrosInfo?.toJson(),
        "meals": meals == null
            ? []
            : List<dynamic>.from(meals!.map((x) => x.toJson())),
        "swaps_info": swapsInfo?.toJson(),
        "hydration_info": hydrationInfo?.toJson(),
      };

  /// Get formatted goal without emoji for display
  String get cleanGoal {
    if (goal == null) return "";
    return goal!.replaceAll(RegExp(r'💪\s*Goal:\s*'), '').trim();
  }

  /// Get formatted calories without emoji for display
  String get cleanCalories {
    if (calories == null) return "";
    return calories!.replaceAll(RegExp(r'🔥\s*Calories:\s*'), '').trim();
  }

  /// Get formatted notes without emoji for display
  String get cleanNotes {
    if (notes == null) return "";
    return notes!.replaceAll(RegExp(r'📝\s*Notes:\s*'), '').trim();
  }

  /// Get total meals count
  int get totalMeals => meals?.length ?? 0;
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

  /// Get clean protein value without emoji
  String get cleanProtein => protein?.replaceAll(RegExp(r'🥩'), '').trim() ?? "";

  /// Get clean carbs value without emoji
  String get cleanCarbs => carbs?.replaceAll(RegExp(r'🍚'), '').trim() ?? "";

  /// Get clean fat value without emoji
  String get cleanFat => fat?.replaceAll(RegExp(r'🥑'), '').trim() ?? "";

  /// Get clean fiber value without emoji
  String get cleanFiber => fiber?.replaceAll(RegExp(r'🌿'), '').trim() ?? "";
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
    
    // Extract emoji and meal type
    final match = RegExp(r'[🍳🥪🥗⚡🐟🥣]\s*([^:]+)').firstMatch(meal!);
    if (match != null) {
      return match.group(1)?.trim() ?? "Meal";
    }
    
    // Fallback to first word
    return meal!.split(':').first.replaceAll(RegExp(r'[^\w\s]'), '').trim();
  }

  /// Extract meal description without emoji and type
  String get cleanDescription {
    if (meal == null) return "";
    
    final parts = meal!.split(':');
    if (parts.length > 1) {
      return parts.sublist(1).join(':').trim();
    }
    
    return meal!.replaceAll(RegExp(r'[🍳🥪🥗⚡🐟🥣]\s*[^:]+:\s*'), '').trim();
  }

  /// Get meal emoji
  String get mealEmoji {
    if (meal == null) return "🍽️";
    
    final emojiMatch = RegExp(r'([🍳🥪🥗⚡🐟🥣])').firstMatch(meal!);
    return emojiMatch?.group(1) ?? "🍽️";
  }

  /// Get formatted calories
  String get formattedCalories => items ?? "0 kcal";

  /// Get formatted protein
  String get formattedProtein => approxKcal ?? "0g";
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

  /// Get clean vegetarian options without emoji
  String get cleanVegetarian {
    if (vegetarian == null) return "";
    return vegetarian!.replaceAll(RegExp(r'🌱\s*Vegetarian:\s*'), '').trim();
  }

  /// Get clean easy options without emoji
  String get cleanEasyOptions {
    if (easyOptions == null) return "";
    return easyOptions!.replaceAll(RegExp(r'⏱️\s*Easy_options:\s*'), '').trim();
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

  /// Get clean hydration info without emoji
  String get cleanHydration {
    if (hydration == null) return "";
    return hydration!.replaceAll(RegExp(r'💧\s*Water\s*'), '').trim();
  }
}