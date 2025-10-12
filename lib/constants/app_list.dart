import 'package:fitai/features/ceckout/models/subscription_type_model.dart';
import 'package:fitai/gen/assets.gen.dart';

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

  static List<String> planSuggestionList = [
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
    "BMI is 27.5 — which falls into the Overweight",
    "The health risk has increased slightly  especially if the weight continues to rise or if there is no regular exercise.",
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
        questionText: "What's your target weight?",
        questionType: QuestionType.numberInput,
        options: [
          OptionModel(optionText: "lbs"),
          OptionModel(optionText: "kg"),
        ],
      ),
      QuestionModel(
        questionText: "What’s your current body type?",
        options: [
          OptionModel(
            optionText: "Ectomorph mane athletics",
            optionImage: Assets.images.fEctomorphManeAthletics.path,
          ),
          OptionModel(
            optionText: "Mesomorph mane muti",
            optionImage: Assets.images.fMesomorphManeMuti.path,
          ),
          OptionModel(
            optionText: "Endomorph mane norom",
            optionImage: Assets.images.fEndomorphManeNoromBody.path,
          ),
        ],
        questionType: QuestionType.slider,
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

      QuestionModel(
        questionText: "What’s your activity level?",
        options: [
          OptionModel(
            optionText: "Not active",
            optionImage: Assets.images.fnotActive.path,
          ),
          OptionModel(
            optionText: "Lightly active",
            optionImage: Assets.images.flightlyActive.path,
          ),
          OptionModel(
            optionText: "Moderately active",
            optionImage: Assets.images.fmoderatelyActive.path,
          ),
          OptionModel(
            optionText: "Very active",
            optionImage: Assets.images.fveryActive.path,
          ),
        ],
        questionType: QuestionType.slider,
      ),

      QuestionModel(
        questionText: "Choose your fitness level",
        options: [
          OptionModel(
            optionText: "Beginner",
            optionImage: Assets.images.beginner.path,
          ),
          OptionModel(
            optionText: "Intermediate",
            optionImage: Assets.images.intermediate.path,
          ),
          OptionModel(
            optionText: "Advanced",
            optionImage: Assets.images.advanced.path,
          ),
        ],
        questionType: QuestionType.slider,
      ),
      QuestionModel(
        questionText: "We helped 3,676,490 people like you reach their goals!",
        questionImage: Assets.images.madvanced.path,
        options: [],
      ),

      QuestionModel(
        questionText: "Can you touch the floor without bending your knees?",
        options: [
          OptionModel(optionText: "I can't"),
          OptionModel(optionText: "I can touch it with my fingertips"),
          OptionModel(optionText: "I can touch it with my palms"),
        ],
      ),
      QuestionModel(
        questionText: "How do you feel after climbing some stairs?",
        options: [
          OptionModel(optionText: "Out of breath"),
          OptionModel(optionText: "Somewhat tired but ok"),
          OptionModel(optionText: "Easily"),
        ],
      ),
      QuestionModel(
        questionText: "Do you relate to the  statement below?",
        questionImage: Assets.images.fdoYouRelate.path,
        questionType: QuestionType.yesNo,
        options: [
          OptionModel(optionText: "Yes"),
          OptionModel(optionText: "No"),
        ],
      ),
      QuestionModel(
        questionText: "FitSnap AI was made for people just like you!",
        questionImage: Assets.images.fjustLikeYou.path,
        options: [],
      ),
      QuestionModel(
        questionText: "Do you wanna lose weight?",
        questionType: QuestionType.yesNo,
        questionImage: Assets.images.flooseWeight.path,
        options: [
          OptionModel(optionText: "Yes"),
          OptionModel(optionText: "No"),
        ],
      ),
      QuestionModel(
        questionText: "Do you want to get an attractive body?",
        questionType: QuestionType.yesNo,
        questionImage: Assets.images.fattractiveBody.path,
        options: [
          OptionModel(optionText: "Yes"),
          OptionModel(optionText: "No"),
        ],
      ),
      QuestionModel(
        questionText: "Upload Your Body Photo.",
        options: [],
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
        questionText: "What's your target weight?",
        questionType: QuestionType.numberInput,
        options: [
          OptionModel(optionText: "lbs"),
          OptionModel(optionText: "kg"),
        ],
      ),
      QuestionModel(
        questionText: "What’s your current body type?",
        options: [
          OptionModel(
            optionText: "Ectomorph mane athletics",
            optionImage: Assets.images.mEctomorphManeAthletics.path,
          ),
          OptionModel(
            optionText: "Mesomorph mane muti",
            optionImage: Assets.images.mMesomorphManeMuti.path,
          ),
          OptionModel(
            optionText: "Endomorph mane norom",
            optionImage: Assets.images.mEndomorphManeNoromBody.path,
          ),
        ],
        questionType: QuestionType.slider,
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

      QuestionModel(
        questionText: "What’s your activity level?",
        options: [
          OptionModel(
            optionText: "Not active",
            optionImage: Assets.images.mnotActive.path,
          ),
          OptionModel(
            optionText: "Lightly active",
            optionImage: Assets.images.mlightlyActive.path,
          ),
          OptionModel(
            optionText: "Moderately active",
            optionImage: Assets.images.mmoderatelyActive.path,
          ),
          OptionModel(
            optionText: "Very active",
            optionImage: Assets.images.mveryActive.path,
          ),
        ],
        questionType: QuestionType.slider,
      ),

      QuestionModel(
        questionText: "Choose your fitness level",
        options: [
          OptionModel(
            optionText: "Beginner",
            optionImage: Assets.images.beginner.path,
          ),
          OptionModel(
            optionText: "Intermediate",
            optionImage: Assets.images.intermediate.path,
          ),
          OptionModel(
            optionText: "Advanced",
            optionImage: Assets.images.advanced.path,
          ),
        ],
        questionType: QuestionType.slider,
      ),
      QuestionModel(
        questionText: "We helped 3,676,490 people like you reach their goals!",
        questionImage: Assets.images.fadvanced.path,
        options: [],
      ),
      QuestionModel(
        questionText: "Can you touch the floor without bending your knees?",
        options: [
          OptionModel(optionText: "I can't"),
          OptionModel(optionText: "I can touch it with my fingertips"),
          OptionModel(optionText: "I can touch it with my palms"),
        ],
      ),
      QuestionModel(
        questionText: "How do you feel after climbing some stairs?",
        options: [
          OptionModel(optionText: "Out of breath"),
          OptionModel(optionText: "Somewhat tired but ok"),
          OptionModel(optionText: "Easily"),
        ],
      ),
      QuestionModel(
        questionText: "Do you relate to the  statement below?",
        questionImage: Assets.images.mdoYouRelate.path,
        questionType: QuestionType.yesNo,
        options: [
          OptionModel(optionText: "Yes"),
          OptionModel(optionText: "No"),
        ],
      ),
      QuestionModel(
        questionText: "FitSnap AI was made for people just like you!",
        questionImage: Assets.images.fjustLikeYou.path,
        options: [],
      ),
      QuestionModel(
        questionText: "Do you wanna lose weight?",
        questionType: QuestionType.yesNo,
        questionImage: Assets.images.mlooseWeight.path,
        options: [
          OptionModel(optionText: "Yes"),
          OptionModel(optionText: "No"),
        ],
      ),
      QuestionModel(
        questionText: "Do you want to get an attractive body?",
        questionType: QuestionType.yesNo,
        questionImage: Assets.images.mattractiveBody.path,
        options: [
          OptionModel(optionText: "Yes"),
          OptionModel(optionText: "No"),
        ],
      ),
      QuestionModel(
        questionText: "Upload Your Body Photo.",
        options: [],
      ),
      // Add more male-specific questions here
    ];
  }
}
