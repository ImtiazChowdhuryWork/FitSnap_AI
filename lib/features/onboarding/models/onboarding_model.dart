import 'dart:convert';

/// Model class for quiz/survey questions with optional images and options with optional images
class QuestionModel {
  final String questionText;
  final String? questionImage;
  final QuestionType questionType;
  final List<OptionModel> options;
  final bool isRequired;
  final String? explanation;

  QuestionModel({
    required this.questionText,
    this.questionImage,
    this.questionType = QuestionType.singleChoice,
    required this.options,
    this.isRequired = true,
    this.explanation,
  });

  QuestionModel copyWith({
    String? questionText,
    String? questionImage,
    QuestionType? questionType,
    List<OptionModel>? options,
    bool? isRequired,
    String? explanation,
  }) =>
      QuestionModel(
        questionText: questionText ?? this.questionText,
        questionImage: questionImage ?? this.questionImage,
        questionType: questionType ?? this.questionType,
        options: options ?? this.options,
        isRequired: isRequired ?? this.isRequired,
        explanation: explanation ?? this.explanation,
      );
}

/// Model class for question options with optional images
class OptionModel {
  final String optionText;
  final String? optionImage;
  final dynamic value;
  final bool isSelected;

  OptionModel({
    required this.optionText,
    this.optionImage,
    this.value,
    this.isSelected = false,
  });

  OptionModel copyWith({
    String? optionText,
    String? optionImage,
    dynamic value,
    bool? isSelected,
  }) =>
      OptionModel(
        optionText: optionText ?? this.optionText,
        optionImage: optionImage ?? this.optionImage,
        value: value ?? this.value,
        isSelected: isSelected ?? this.isSelected,
      );
}

/// Enum for different types of questions
enum QuestionType {
  singleChoice,
  multipleChoice,
  textInput,
  numberInput,
  dateInput,
  rating,
  slider,
  yesNo,
}

/// Model class for Onboarding Response Collection
class OnboardingResponseModel {
  final OnboardingData onboarding;
  final String? bodyImage;

  OnboardingResponseModel({
    required this.onboarding,
    this.bodyImage,
  });

  OnboardingResponseModel copyWith({
    OnboardingData? onboarding,
    String? bodyImage,
  }) =>
      OnboardingResponseModel(
        onboarding: onboarding ?? this.onboarding,
        bodyImage: bodyImage ?? this.bodyImage,
      );

  factory OnboardingResponseModel.fromRawJson(String str) =>
      OnboardingResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OnboardingResponseModel.fromJson(Map<String, dynamic> json) =>
      OnboardingResponseModel(
        onboarding: OnboardingData.fromJson(json["onboarding"]),
        bodyImage: json["body_image"],
      );

  Map<String, dynamic> toJson() => {
        "onboarding": onboarding.toJson(),
        "body_image": bodyImage,
      };
}

/// Model class for Onboarding Data
class OnboardingData {
  final String? whoAreYou;
  final String? whatMotivatesYouMost;
  final String? whatsYourMainGoal;
  final String? whatIsYourFocusArea;
  final String? whatIsYourHeight;
  final String? whatsIsYourCurrentWeight;
  final String? whatsIsYourTargetWeight;
  final String? whatsIsYourCurrentBodyType;
  final String? haveYouEverBeenInjuredInTheseAreas;
  final String? whatTypeOfWorkoutSuitsYouBest;
  final String? whatIsYourActivityLevel;
  final String? chooseFitnessLevel;
  final String? canYouTouchTheFloorWithoutBendingYourKnees;
  final String? howDoYouFeelAfterClimbingSomeStairs;
  final String? doYouRelateToTheStatementBelow;
  final String? doYouWannaLoseWeight;
  final String? doYouWannaGetAnAttractiveBody;

  OnboardingData({
    this.whoAreYou,
    this.whatMotivatesYouMost,
    this.whatsYourMainGoal,
    this.whatIsYourFocusArea,
    this.whatIsYourHeight,
    this.whatsIsYourCurrentWeight,
    this.whatsIsYourTargetWeight,
    this.whatsIsYourCurrentBodyType,
    this.haveYouEverBeenInjuredInTheseAreas,
    this.whatTypeOfWorkoutSuitsYouBest,
    this.whatIsYourActivityLevel,
    this.chooseFitnessLevel,
    this.canYouTouchTheFloorWithoutBendingYourKnees,
    this.howDoYouFeelAfterClimbingSomeStairs,
    this.doYouRelateToTheStatementBelow,
    this.doYouWannaLoseWeight,
    this.doYouWannaGetAnAttractiveBody,
  });

  OnboardingData copyWith({
    String? whoAreYou,
    String? whatMotivatesYouMost,
    String? whatsYourMainGoal,
    String? whatIsYourFocusArea,
    String? whatIsYourHeight,
    String? whatsIsYourCurrentWeight,
    String? whatsIsYourTargetWeight,
    String? whatsIsYourCurrentBodyType,
    String? haveYouEverBeenInjuredInTheseAreas,
    String? whatTypeOfWorkoutSuitsYouBest,
    String? whatIsYourActivityLevel,
    String? chooseFitnessLevel,
    String? canYouTouchTheFloorWithoutBendingYourKnees,
    String? howDoYouFeelAfterClimbingSomeStairs,
    String? doYouRelateToTheStatementBelow,
    String? doYouWannaLoseWeight,
    String? doYouWannaGetAnAttractiveBody,
  }) =>
      OnboardingData(
        whoAreYou: whoAreYou ?? this.whoAreYou,
        whatMotivatesYouMost: whatMotivatesYouMost ?? this.whatMotivatesYouMost,
        whatsYourMainGoal: whatsYourMainGoal ?? this.whatsYourMainGoal,
        whatIsYourFocusArea: whatIsYourFocusArea ?? this.whatIsYourFocusArea,
        whatIsYourHeight: whatIsYourHeight ?? this.whatIsYourHeight,
        whatsIsYourCurrentWeight:
            whatsIsYourCurrentWeight ?? this.whatsIsYourCurrentWeight,
        whatsIsYourTargetWeight:
            whatsIsYourTargetWeight ?? this.whatsIsYourTargetWeight,
        whatsIsYourCurrentBodyType:
            whatsIsYourCurrentBodyType ?? this.whatsIsYourCurrentBodyType,
        haveYouEverBeenInjuredInTheseAreas:
            haveYouEverBeenInjuredInTheseAreas ??
                this.haveYouEverBeenInjuredInTheseAreas,
        whatTypeOfWorkoutSuitsYouBest:
            whatTypeOfWorkoutSuitsYouBest ?? this.whatTypeOfWorkoutSuitsYouBest,
        whatIsYourActivityLevel:
            whatIsYourActivityLevel ?? this.whatIsYourActivityLevel,
        chooseFitnessLevel: chooseFitnessLevel ?? this.chooseFitnessLevel,
        canYouTouchTheFloorWithoutBendingYourKnees:
            canYouTouchTheFloorWithoutBendingYourKnees ??
                this.canYouTouchTheFloorWithoutBendingYourKnees,
        howDoYouFeelAfterClimbingSomeStairs:
            howDoYouFeelAfterClimbingSomeStairs ??
                this.howDoYouFeelAfterClimbingSomeStairs,
        doYouRelateToTheStatementBelow: doYouRelateToTheStatementBelow ??
            this.doYouRelateToTheStatementBelow,
        doYouWannaLoseWeight: doYouWannaLoseWeight ?? this.doYouWannaLoseWeight,
        doYouWannaGetAnAttractiveBody:
            doYouWannaGetAnAttractiveBody ?? this.doYouWannaGetAnAttractiveBody,
      );

  factory OnboardingData.fromRawJson(String str) =>
      OnboardingData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OnboardingData.fromJson(Map<String, dynamic> json) => OnboardingData(
        whoAreYou: json["who_are_you"],
        whatMotivatesYouMost: json["what_motivates_you_most"],
        whatsYourMainGoal: json["whats_your_main_goal"],
        whatIsYourFocusArea: json["what_is_your_focus_area"],
        whatIsYourHeight: json["what_is_your_height"],
        whatsIsYourCurrentWeight: json["whats_is_your_current_weight"],
        whatsIsYourTargetWeight: json["whats_is_your_target_weight"],
        whatsIsYourCurrentBodyType: json["whats_is_your_current_body_type"],
        haveYouEverBeenInjuredInTheseAreas:
            json["have_you_ever_been_injured_in_these_areas"],
        whatTypeOfWorkoutSuitsYouBest:
            json["what_type_of_workout_suits_you_best"],
        whatIsYourActivityLevel: json["what_is_your_activity_level"],
        chooseFitnessLevel: json["choose_fitness_level"],
        canYouTouchTheFloorWithoutBendingYourKnees:
            json["can_you_touch_the_floor_without_bending_your_knees"],
        howDoYouFeelAfterClimbingSomeStairs:
            json["how_do_you_feel_after_climbing_some_stairs"],
        doYouRelateToTheStatementBelow:
            json["do_you_relate_to_the_statement_below"],
        doYouWannaLoseWeight: json["do_you_wanna_lose_weight"],
        doYouWannaGetAnAttractiveBody:
            json["do_you_wanna_get_an_attractive_body"],
      );

  Map<String, dynamic> toJson() => {
        "who_are_you": whoAreYou,
        "what_motivates_you_most": whatMotivatesYouMost,
        "whats_your_main_goal": whatsYourMainGoal,
        "what_is_your_focus_area": whatIsYourFocusArea,
        "what_is_your_height": whatIsYourHeight,
        "whats_is_your_current_weight": whatsIsYourCurrentWeight,
        "whats_is_your_target_weight": whatsIsYourTargetWeight,
        "whats_is_your_current_body_type": whatsIsYourCurrentBodyType,
        "have_you_ever_been_injured_in_these_areas":
            haveYouEverBeenInjuredInTheseAreas,
        "what_type_of_workout_suits_you_best": whatTypeOfWorkoutSuitsYouBest,
        "what_is_your_activity_level": whatIsYourActivityLevel,
        "choose_fitness_level": chooseFitnessLevel,
        "can_you_touch_the_floor_without_bending_your_knees":
            canYouTouchTheFloorWithoutBendingYourKnees,
        "how_do_you_feel_after_climbing_some_stairs":
            howDoYouFeelAfterClimbingSomeStairs,
        "do_you_relate_to_the_statement_below": doYouRelateToTheStatementBelow,
        "do_you_wanna_lose_weight": doYouWannaLoseWeight,
        "do_you_wanna_get_an_attractive_body": doYouWannaGetAnAttractiveBody,
      };
}

/// Helper class to manage onboarding flow based on gender
class OnboardingFlowManager {
  static const String GENDER_MALE = "Male";
  static const String GENDER_FEMALE = "Female";

  /// Get the appropriate question list based on selected gender
  static List<QuestionModel> getQuestionsForGender(String? gender) {
    if (gender == null) {
      // Return default questions if no gender selected yet
      return _getDefaultQuestions();
    }

    switch (gender.toLowerCase()) {
      case 'male':
        // Import AppList to use the actual question lists
        // return AppList.getMaleOnboardingQuestions();
        return _getDefaultQuestions(); // Fallback until AppList is imported
      case 'female':
        // Import AppList to use the actual question lists
        // return AppList.getFemaleOnboardingQuestions();
        return _getDefaultQuestions(); // Fallback until AppList is imported
      default:
        return _getDefaultQuestions();
    }
  }

  /// Get default/common questions (gender selection and motivation)
  static List<QuestionModel> _getDefaultQuestions() {
    return [
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
  }

  /// Check if current question should branch based on gender
  static bool shouldBranchByGender(int questionIndex) {
    return questionIndex >= 2; // Questions after gender and motivation
  }

  /// Get next question index based on current responses
  static int getNextQuestionIndex(
      int currentIndex, Map<String, String> responses) {
    // Add logic for conditional question flow
    return currentIndex + 1;
  }
}
