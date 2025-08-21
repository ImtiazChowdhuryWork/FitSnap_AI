import 'package:fitsnap_ai/features/ceckout/models/subscription_type_model.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';

import '../features/meal/models/custom_meal_card_model.dart';
import '../features/onboarding/models/onboarding_model.dart';

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

  /// Onboarding Question Option Answer List
  static List<QuestionModel> onboardingQuestionList = [
    QuestionModel(
      questionText: "Who are you?",
      options: [
        OptionModel(optionText: "Female"),
        OptionModel(optionText: "Male"),
      ],
    ),
    QuestionModel(
      questionText: "What motivates you most?",
      options: [
        OptionModel(optionText: "Get Shaped"),
        OptionModel(optionText: "Look Better"),
        OptionModel(optionText: "Become Healthier"),
        OptionModel(optionText: "Feel Confident"),
      ],
    ),
  ];

  /// Gender-specific onboarding questions
  static List<QuestionModel> getFemaleOnboardingQuestions() {
    return [
      onboardingQuestionList[0], // Who are you?
      onboardingQuestionList[1], // What motivates you most?
      QuestionModel(
        questionText: "What's your main goal?",
        options: [
          OptionModel(
            optionText: "Lose weight",
            optionImage: Assets.images.flooseweight.path,
          ),
          OptionModel(
            optionText: "Build muscle",
            optionImage: Assets.images.fbuildmuscle.path,
          ),
          OptionModel(
            optionText: "Keep fit",
            optionImage: Assets.images.fkeepfit.path,
          ),
          OptionModel(
            optionText: "Improve flexibility",
            optionImage: Assets.images.fimproveflexibility.path,
          ),
        ],
      ),
      QuestionModel(
        questionText: "What's your focus area?",
        questionImage: Assets.images.fwhatisyourfocusarea.path,
        options: [
          OptionModel(
            optionText: "Arms",
          ),
          OptionModel(
            optionText: "Belly",
          ),
          OptionModel(
            optionText: "Butt",
          ),
          OptionModel(
            optionText: "Full Body",
          ),
        ],
      ),
      QuestionModel(
        questionText: "Your body will transform just like this!",
        questionImage: Assets.images.fbodytransform.path,
        options: [],
      ),
      QuestionModel(
        questionText: "What is your name?",
        questionType: QuestionType.textInput,
        options: [],
      ),
      QuestionModel(
        questionText: "What's your height?",
        questionType: QuestionType.numberInput,
        options: [
          OptionModel(optionText: "ft"),
          OptionModel(optionText: "cm"),
        ],
      ),
      QuestionModel(
        questionText: "What's your current weight?",
        questionType: QuestionType.numberInput,
        options: [
          OptionModel(optionText: "lbs"),
          OptionModel(optionText: "kg"),
        ],
      ),
      QuestionModel(
        questionText: "Have you ever been injured in these areas?",
        options: [
          OptionModel(optionText: "None"),
          OptionModel(optionText: "Back"),
          OptionModel(optionText: "Leg"),
          OptionModel(optionText: "Knee"),
        ],
      ),
      QuestionModel(
        questionText: "What type of workout suits you best?",
        options: [
          OptionModel(optionText: "Indoor Walking"),
          OptionModel(optionText: "Chair Workout"),
          OptionModel(optionText: "Pilates"),
          OptionModel(optionText: "Cardio"),
        ],
      ),
      // Add more female-specific questions here
    ];
  }

  static List<QuestionModel> getMaleOnboardingQuestions() {
    return [
      onboardingQuestionList[0], // Who are you?
      onboardingQuestionList[1], // What motivates you most?
      QuestionModel(
        questionText: "What's your main goal?",
        options: [
          OptionModel(
            optionText: "Burn Fat",
            optionImage: Assets.images.mburnfat.path,
          ),
          OptionModel(
            optionText: "Stay Active & Energized",
            optionImage: Assets.images.mstayactive.path,
          ),
          OptionModel(
            optionText: "Tone Arms, Abs",
            optionImage: Assets.images.mtonearmsabs.path,
          ),
          OptionModel(
            optionText: "Build muscle",
            optionImage: Assets.images.mbuildmuscle.path,
          ),
        ],
      ),
      QuestionModel(
        questionText: "What's your focus area?",
        questionImage: Assets.images.mwhatisyourfocusarea.path,
        options: [
          OptionModel(
            optionText: "Arms",
          ),
          OptionModel(
            optionText: "Belly",
          ),
          OptionModel(
            optionText: "Butt",
          ),
          OptionModel(
            optionText: "Full Body",
          ),
        ],
      ),
      QuestionModel(
        questionText: "Your body will transform just like this!",
        questionImage: Assets.images.mbodytransform.path,
        options: [],
      ),
      QuestionModel(
        questionText: "What is your name?",
        questionType: QuestionType.textInput,
        options: [],
      ),
      QuestionModel(
        questionText: "What's your height?",
        questionType: QuestionType.numberInput,
        options: [
          OptionModel(optionText: "ft"),
          OptionModel(optionText: "cm"),
        ],
      ),
      QuestionModel(
        questionText: "What's your current weight?",
        questionType: QuestionType.numberInput,
        options: [
          OptionModel(optionText: "lbs"),
          OptionModel(optionText: "kg"),
        ],
      ),
      QuestionModel(
        questionText: "Have you ever been injured in these areas?",
        options: [
          OptionModel(optionText: "None"),
          OptionModel(optionText: "Back"),
          OptionModel(optionText: "Leg"),
          OptionModel(optionText: "Knee"),
        ],
      ),
      QuestionModel(
        questionText: "What type of workout suits you best?",
        options: [
          OptionModel(optionText: "Indoor Walking"),
          OptionModel(optionText: "Chair Workout"),
          OptionModel(optionText: "Pilates"),
          OptionModel(optionText: "Cardio"),
        ],
      ),
      // Add more male-specific questions here
    ];
  }
}
