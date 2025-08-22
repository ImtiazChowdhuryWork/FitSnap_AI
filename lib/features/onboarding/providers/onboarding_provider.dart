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

    // Debug: log selection writes
    debugPrint('selectOption -> [$questionKey] = $optionText');

    notifyListeners();
  }

  void setTextInput(String inputText, String questionKey,
      {bool affectSelection = true}) {
    _responses[questionKey] = inputText;
    if (affectSelection) {
      _selectedOptionForCurrentQuestion =
          inputText.isNotEmpty ? inputText : null;
    }
    // Debug: log text writes
    debugPrint('setTextInput -> [$questionKey] = $inputText');
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
    // Compute BMI from stored height and weight if possible.
    try {
      updateCombinedHeight('whats_your_height');
    } catch (_) {}

    final heightStr = _responses['whats_your_height'] ??
        _responses['what_is_your_height'] ??
        '';
    final weightStr = _responses['whats_your_current_weight'] ??
        _responses['whats_is_your_current_weight'] ??
        _responses['what_is_your_current_weight'] ??
        '';

    double? meters;
    // parse cm
    if (heightStr.toLowerCase().contains('cm')) {
      final num =
          double.tryParse(heightStr.replaceAll(RegExp(r'[^0-9\.]'), ''));
      if (num != null) meters = num / 100.0;
    } else {
      // parse ft and in like '5 ft 7 in' or '5ft 7in'
      final ftIn = RegExp(r"(\d+)\s*ft(?:\s*(\d+)\s*in)?", caseSensitive: false)
          .firstMatch(heightStr);
      if (ftIn != null) {
        final ft = int.tryParse(ftIn.group(1) ?? '0') ?? 0;
        final inch = int.tryParse(ftIn.group(2) ?? '0') ?? 0;
        final totalInches = ft * 12 + inch;
        meters = totalInches * 0.0254;
      } else {
        // fallback: try to parse a plain number and treat > 3 as cm
        final num =
            double.tryParse(heightStr.replaceAll(RegExp(r'[^0-9\.]'), ''));
        if (num != null) {
          if (num > 3) {
            meters = num / 100.0;
          } else {
            meters = num; // assume meters
          }
        }
      }
    }

    double? kg;
    if (weightStr.toLowerCase().contains('kg')) {
      final num =
          double.tryParse(weightStr.replaceAll(RegExp(r'[^0-9\.]'), ''));
      if (num != null) kg = num;
    } else if (weightStr.toLowerCase().contains('lb')) {
      final num =
          double.tryParse(weightStr.replaceAll(RegExp(r'[^0-9\.]'), ''));
      if (num != null) kg = num * 0.45359237;
    } else {
      final num =
          double.tryParse(weightStr.replaceAll(RegExp(r'[^0-9\.]'), ''));
      if (num != null) {
        // ambiguous unit; assume kg if plausible
        if (num > 30) {
          kg = num; // assume kg
        } else {
          kg = num; // small weights still treat as kg
        }
      }
    }

    if (kg == null || meters == null || meters == 0) {
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

  // Normalize and find helper used when building final payload
  String? _find(String canonical) {
    String normalize(String s) => s
        .toLowerCase()
        .replaceAll(RegExp(r"[’'`\u2019]"), '')
        .replaceAll(RegExp(r"[^a-z0-9]"), '_')
        .replaceAll(RegExp(r"_+"), '_')
        .replaceAll(RegExp(r"^_|_"), '');

    final target = normalize(canonical);
    for (final entry in _responses.entries) {
      if (normalize(entry.key) == target) return entry.value;
    }
    return null;
  }

  // Find a response where the normalized key contains all provided keywords.
  String? _findByKeywords(List<String> keywords) {
    if (keywords.isEmpty) return null;
    final wantList = keywords.map((k) => k.toLowerCase()).toList();
    for (final entry in _responses.entries) {
      final nk = entry.key.toLowerCase().replaceAll(RegExp(r"[’'`\u2019]"), '').replaceAll(RegExp(r"[^a-z0-9]"), '_');
      final condensed = nk.replaceAll(RegExp(r"_+"), '_').replaceAll(RegExp(r"^_|_"), '');
      final matched = wantList.every((kw) => condensed.contains(kw));
      if (matched) return entry.value;
    }
    return null;
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
    // Ensure combined height stored from parts before packaging
    try {
      updateCombinedHeight('whats_your_height');
    } catch (_) {}

    // Debug: show all collected responses
    debugPrint('DEBUG responses: $_responses');

    // Capture any responses that were written with an empty key ("")
    final blankKeyValues = _responses.entries
        .where((e) => e.key.trim().isEmpty)
        .map((e) => e.value)
        .toList();

    // Helper to pop a value from blankKeyValues if available
    String? popBlank() =>
        blankKeyValues.isNotEmpty ? blankKeyValues.removeAt(0) : null;

    final who = _find('who_are_you');
    final motive = _find('what_motivates_you_most');
    final goal = _find('whats_your_main_goal');
    final focus = _find('what_is_your_focus_area');
    final height = _find('whats_your_height') ?? _find('what_is_your_height');
    final currentWeight = _find('whats_your_current_weight') ??
        _find('what_is_your_current_weight');
    final targetWeight =
        _find('whats_your_target_weight') ?? _find('target_weight');
    final bodyType = _find('whats_your_current_body_type') ??
        _find('what_is_your_current_body_type');
    final injured = _find('have_you_ever_been_injured_in_these_areas');
    final workoutType =
        _find('what_type_of_workout_suits_you_best') ?? _find('workout_type');
    final activity = _find('what_is_your_activity_level') ??
        _find('whats_your_activity_level');
    final fitness =
        _find('choose_your_fitness_level') ?? _find('choose_fitness_level');
    final touchFloor =
        _find('can_you_touch_the_floor_without_bending_your_knees');
    final stairs = _find('how_do_you_feel_after_climbing_some_stairs') ??
        _find('how_do_you_feel_after_climbing_stairs');
    final relate = _find('do_you_relate_to_the_statement_below') ??
        _find('do_you_relate_to_the__statement_below');

  // The two boolean questions sometimes were written with empty keys in logs.
  // Use keyword-based search and blankKeyValues as fallbacks if missing.
  final wannaLose = _find('do_you_wanna_lose_weight') ??
    _findByKeywords(['lose', 'weight']) ??
    popBlank();
  final wannaAttractive = _find('do_you_wanna_get_an_attractive_body') ??
    _findByKeywords(['attractive', 'body']) ??
    popBlank();

    final onboardingData = OnboardingData(
      whoAreYou: who,
      whatMotivatesYouMost: motive,
      whatsYourMainGoal: goal,
      whatIsYourFocusArea: focus,
      whatIsYourHeight: height,
      whatsIsYourCurrentWeight: currentWeight,
      whatsIsYourTargetWeight: targetWeight,
      whatsIsYourCurrentBodyType: bodyType,
      haveYouEverBeenInjuredInTheseAreas: injured,
      whatTypeOfWorkoutSuitsYouBest: workoutType,
      whatIsYourActivityLevel: activity,
      chooseFitnessLevel: fitness,
      canYouTouchTheFloorWithoutBendingYourKnees: touchFloor,
      howDoYouFeelAfterClimbingSomeStairs: stairs,
      doYouRelateToTheStatementBelow: relate,
      doYouWannaLoseWeight: wannaLose,
      doYouWannaGetAnAttractiveBody: wannaAttractive,
    );

    final onboardingResponse = OnboardingResponseModel(
      onboarding: onboardingData,
      bodyImage: _responses['body_image'],
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
        return _normalizeKey("whats_your_height");
      case "What's your current weight?":
        return _normalizeKey("whats_your_current_weight");
      default:
        return _normalizeKey(questionText);
    }
  }

  void reset() {
    _currentQuestionIndex = 0;
    _selectedGender = null;
    _responses.clear();
    _selectedOptionForCurrentQuestion = null;
    notifyListeners();
  }

  // Normalize a question/key string into the canonical response key used in _responses
  String _normalizeKey(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r"[’'`\u2019]"), '')
        .replaceAll(RegExp(r"[^a-z0-9]"), '_')
        .replaceAll(RegExp(r"_+"), '_')
        .replaceAll(RegExp(r"^_|_"), '');
  }
}
