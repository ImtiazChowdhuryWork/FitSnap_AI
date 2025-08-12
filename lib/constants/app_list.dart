import 'package:fitsnap_ai/features/ceckout/models/subscription_type_model.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';

import '../features/meal/models/custom_meal_card_model.dart';

class AppList {
  static List<CustomMealCardModel> mealLit = [
    CustomMealCardModel(
      mealType: "Snack",
      mealDescription: "Banana + Nuts. Instant energy boost",
      mealImage: Assets.images.mealImageDesart.path,
    ),
    CustomMealCardModel(
      mealType: "Lunch",
      mealDescription:
          "Brown Rice + Chicken Curry + Salad. Low fat, balanced nutrients",
      mealImage: Assets.images.mealImageLunch.path,
    ),
    CustomMealCardModel(
      mealType: "Breakfast",
      mealDescription: "Yogurt + Oats + Fruits. High protein, rich in fiber",
      mealImage: Assets.images.mealImageBreakfast.path,
    ),
    CustomMealCardModel(
      mealType: "Lunch",
      mealDescription:
          "Brown Rice + Chicken Curry + Salad. Low fat, balanced nutrients",
      mealImage: Assets.images.mealImageLunch.path,
    ),
    CustomMealCardModel(
      mealType: "Snack",
      mealDescription: "Banana + Nuts. Instant energy boost",
      mealImage: Assets.images.mealImageDesart.path,
    ),
    CustomMealCardModel(
      mealType: "Breakfast",
      mealDescription: "Yogurt + Oats + Fruits. High protein, rich in fiber",
      mealImage: Assets.images.mealImageBreakfast.path,
    ),
    CustomMealCardModel(
      mealType: "Lunch",
      mealDescription:
          "Brown Rice + Chicken Curry + Salad. Low fat, balanced nutrients",
      mealImage: Assets.images.mealImageLunch.path,
    ),
    CustomMealCardModel(
      mealType: "Breakfast",
      mealDescription: "Yogurt + Oats + Fruits. High protein, rich in fiber",
      mealImage: Assets.images.mealImageBreakfast.path,
    ),
    CustomMealCardModel(
      mealType: "Snack",
      mealDescription: "Banana + Nuts. Instant energy boost",
      mealImage: Assets.images.mealImageDesart.path,
    ),
  ];

  ///Subscription Type List
  static List<SubscriptionTypeModel> subscriptionTypeList = [
    SubscriptionTypeModel(type: "Free", price: "7days"),
    SubscriptionTypeModel(type: "1 month ", price: "500"),
    SubscriptionTypeModel(type: "1 year", price: "6000"),
  ];
}
