import 'package:flutter/foundation.dart';

import '../../../constants/app_list.dart';
import '../models/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  String? _selectedGender;
  final Map<String, String> _responses = {};
  String? _selectedOptionForCurrentQuestion;
  double? _bmi;
  String? _bmiCategory;

  // Getters
  int get currentQuestionIndex => _currentQuestionIndex;
  String? get selectedGender => _selectedGender;
  Map<String, String> get responses => _responses;
  String? get selectedOptionForCurrentQuestion =>
      _selectedOptionForCurrentQuestion;
  double? get bmi => _bmi;
  String? get bmiCategory => _bmiCategory;

  List<QuestionModel> get currentQuestions {
    if (_selectedGender == null) {
      return AppList.onboardingQuestionList;
    } else if (_selectedGender == "Male") {
      return AppList.getMaleOnboardingQuestions();
    } else {
      return AppList.getFemaleOnboardingQuestions();
    }
  }

  bool get hasSelectedOption => _selectedOptionForCurrentQuestion != null;

  // Methods
  void selectOption(String optionText, String questionKey) {
    _selectedOptionForCurrentQuestion = optionText;
    _responses[questionKey] = optionText;

    // Handle gender selection
    if (questionKey == "who_are_you") {
      _selectedGender = optionText;
    }

    notifyListeners();
  }

  void setTextInput(String inputText, String questionKey,
      {bool affectSelection = true}) {
    _responses[questionKey] = inputText;
    if (affectSelection) {
      _selectedOptionForCurrentQuestion =
          inputText.isNotEmpty ? inputText : null;
    }
    notifyListeners();
  }

  /// Combine stored height parts into the main height key without altering unit selection
  void updateCombinedHeight(String baseKey) {
    final ft = _responses['${baseKey}_ft'] ?? '';
    final inch = _responses['${baseKey}_in'] ?? '';
    final cm = _responses['${baseKey}_cm'] ?? '';
    String combined;
    if (cm.isNotEmpty) {
      combined = '$cm cm';
    } else {
      if (ft.isNotEmpty && inch.isNotEmpty) {
        combined = '$ft ft $inch in';
      } else if (ft.isNotEmpty) {
        combined = '$ft ft';
      } else {
        combined = '';
      }
    }
    _responses[baseKey] = combined;
    _computeBMI();
    notifyListeners();
  }

  void _computeBMI() {
    // Expect keys: whats_your_height, whats_your_current_weight
    final heightStr = _responses['whats_your_height'];
    final weightStr = _responses['whats_your_current_weight'];
    if (heightStr == null ||
        heightStr.isEmpty ||
        weightStr == null ||
        weightStr.isEmpty) {
      _bmi = null;
      _bmiCategory = null;
      return;
    }
    double? meters;
    if (heightStr.contains('cm')) {
      final numMatch = RegExp(r"(\d+(?:\.\d+)?)").firstMatch(heightStr);
      if (numMatch != null) {
        meters = double.tryParse(numMatch.group(1)!)! / 100.0;
      }
    } else if (heightStr.contains('ft')) {
      final ftMatch = RegExp(r"(\d+) ft").firstMatch(heightStr);
      final inMatch = RegExp(r"(\d+) in").firstMatch(heightStr);
      final ft = ftMatch != null ? double.tryParse(ftMatch.group(1)!) ?? 0 : 0;
      final inch =
          inMatch != null ? double.tryParse(inMatch.group(1)!) ?? 0 : 0;
      meters = ((ft * 12) + inch) * 0.0254;
    }
    if (meters == null || meters == 0) {
      _bmi = null;
      _bmiCategory = null;
      return;
    }
    double? kg;
    if (weightStr.contains('kg')) {
      final m = RegExp(r"(\d+(?:\.\d+)?)").firstMatch(weightStr);
      if (m != null) kg = double.tryParse(m.group(1)!);
    } else if (weightStr.contains('lbs')) {
      final m = RegExp(r"(\d+(?:\.\d+)?)").firstMatch(weightStr);
      if (m != null) {
        final lbs = double.tryParse(m.group(1)!);
        if (lbs != null) kg = lbs * 0.45359237;
      }
    }
    if (kg == null || kg == 0) {
      _bmi = null;
      _bmiCategory = null;
      return;
    }
    _bmi = kg / (meters * meters);
    if (_bmi! < 18.5) {
      _bmiCategory = 'Underweight';
    } else if (_bmi! < 25) {
      _bmiCategory = 'Normal';
    } else if (_bmi! < 30) {
      _bmiCategory = 'Overweight';
    } else {
      _bmiCategory = 'Obese';
    }
  }

  void updateWeight(String baseKey, String rawDigits) {
    final unit = _selectedOptionForCurrentQuestion ?? 'lbs';
    if (rawDigits.isEmpty) {
      _responses[baseKey] = '';
    } else {
      _responses[baseKey] = rawDigits + unit; // no space per spec
    }
    _computeBMI();
    notifyListeners();
  }

  void goToNextQuestion() {
    if (_currentQuestionIndex < currentQuestions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionForCurrentQuestion = null;
      notifyListeners();
    } else {
      // All questions completed
      completeOnboarding();
    }
  }

  void goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _selectedOptionForCurrentQuestion = null;
      notifyListeners();
    }
  }

  void setCurrentQuestionIndex(int index) {
    _currentQuestionIndex = index;
    _selectedOptionForCurrentQuestion = null;
    notifyListeners();
  }

  void completeOnboarding() {
    final onboardingData = OnboardingData(
      whoAreYou: _responses["who_are_you"],
      whatMotivatesYouMost: _responses["what_motivates_you_most"],
      whatsYourMainGoal: _responses["whats_your_main_goal"],
      whatIsYourFocusArea: _responses["what_is_your_focus_area"],
      whatIsYourHeight: _responses["what_is_your_height"],
      whatsIsYourCurrentWeight: _responses["whats_is_your_current_weight"],
      whatsIsYourTargetWeight: _responses["whats_is_your_target_weight"],
      whatsIsYourCurrentBodyType: _responses["whats_is_your_current_body_type"],
      haveYouEverBeenInjuredInTheseAreas:
          _responses["have_you_ever_been_injured_in_these_areas"],
      whatTypeOfWorkoutSuitsYouBest:
          _responses["what_type_of_workout_suits_you_best"],
      whatIsYourActivityLevel: _responses["what_is_your_activity_level"],
      chooseFitnessLevel: _responses["choose_fitness_level"],
      canYouTouchTheFloorWithoutBendingYourKnees:
          _responses["can_you_touch_the_floor_without_bending_your_knees"],
      howDoYouFeelAfterClimbingSomeStairs:
          _responses["how_do_you_feel_after_climbing_some_stairs"],
      doYouRelateToTheStatementBelow:
          _responses["do_you_relate_to_the_statement_below"],
      doYouWannaLoseWeight: _responses["do_you_wanna_lose_weight"],
      doYouWannaGetAnAttractiveBody:
          _responses["do_you_wanna_get_an_attractive_body"],
    );

    final onboardingResponse = OnboardingResponseModel(
      onboarding: onboardingData,
      // bodyImage: will be added later
    );

    // Print or send to API
    print("Onboarding Response: ${onboardingResponse.toRawJson()}");

    // Navigate to next screen or handle completion
    // You can add navigation logic here
  }

  String getQuestionKey(String questionText) {
    switch (questionText) {
      case "Who are you?":
        return "who_are_you";
      case "What motivates you most?":
        return "what_motivates_you_most";
      case "What's your main goal?":
        return "whats_your_main_goal";
      case "What's your focus area?":
        return "what_is_your_focus_area";
      case "What is your name?":
        return "what_is_your_name";
      case "What's your height?":
        return "whats_your_height";
      case "What's your current weight?":
        return "whats_your_current_weight";
      default:
        return questionText
            .toLowerCase()
            .replaceAll(" ", "_")
            .replaceAll("?", "")
            .replaceAll("'", "");
    }
  }

  void reset() {
    _currentQuestionIndex = 0;
    _selectedGender = null;
    _responses.clear();
    _selectedOptionForCurrentQuestion = null;
    notifyListeners();
  }
}
