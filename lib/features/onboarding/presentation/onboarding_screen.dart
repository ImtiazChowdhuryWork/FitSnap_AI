import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fitsnap_ai/common_widgets/custom_text_form_field.dart';
import '../models/onboarding_model.dart';
import '../providers/onboarding_provider.dart';
import '../../../../provider/impage_picker_provider_fitsnap.dart';

// Custom Progress Bar Widget
class CustomProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double height;
  final Color backgroundColor;
  final List<Color> gradientColors;

  const CustomProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.height = 14.0,
    this.backgroundColor = AppColors.cE6E8ED,
    this.gradientColors = const [
      AppColors.c3B13CA,
      AppColors.c0000ff,
      AppColors.c5454FF,
    ],
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress: 0% for first step, 100% for last step
    final progress = totalSteps > 1 ? (currentStep) / (totalSteps - 1) : 0.0;

    return Column(
      children: [
        Container(
          height: height.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Step $currentStep of $totalSteps",
          style: TextStyle(
            color: AppColors.c000000,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

// Updated CustomElevatedButton for a professional look
class CustomElevatedButton extends StatelessWidget {
  final String buttonTitle;
  final double? buttonWidth;
  final Color? buttonColor;
  final VoidCallback? onTap;

  const CustomElevatedButton({
    super.key,
    required this.buttonTitle,
    this.buttonWidth,
    this.buttonColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: buttonWidth ?? double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: buttonColor != null
                  ? [buttonColor!, buttonColor!.withOpacity(0.8)]
                  : [AppColors.c0000ff, AppColors.c5454FF],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Updated CustomCard for a professional look
class CustomCard extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? child;

  const CustomCard({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? AppColors.cE6E8ED,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// Updated CustomContainer for a professional look
class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  // Text controllers for different input types
  final Map<String, TextEditingController> _controllers = {};

  DateTime? _lastBackPressed;

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(String key, String initialValue) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: initialValue);
    }
    return _controllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OnboardingProvider, ImagePickerProviderFitsnap>(
      builder: (context, onboardingProvider, imagePickerProvider, child) {
        return PopScope(
          canPop: false, // Prevent default pop, handle manually
          onPopInvokedWithResult: (didPop, result) async {
            // Handle iOS and Android differently
            if (didPop) return; // Already popped, don't handle again
            
            if (onboardingProvider.currentQuestionIndex == 0) {
              final now = DateTime.now();
              if (_lastBackPressed == null ||
                  now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
                _lastBackPressed = now;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Press back again to exit'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              // Force exit for iOS compatibility
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              return;
            } else {
              // Navigate to previous question
              onboardingProvider.goToPreviousQuestion();
              await _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              return;
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true, // Allow iOS keyboard handling

            ///AppBar
            appBar: AppBar(
              backgroundColor: onboardingProvider.currentQuestionIndex == 4
                  ? AppColors.c0000ff
                  : Color(0xFFFFFFFF),
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark, // iOS status bar
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.sp),
                onPressed: () {
                  if (onboardingProvider.currentQuestionIndex == 0) {
                    final now = DateTime.now();
                    if (_lastBackPressed == null ||
                        now.difference(_lastBackPressed!) >
                            Duration(seconds: 2)) {
                      _lastBackPressed = now;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Press back again to exit'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      SystemNavigator.pop();
                    }
                  } else {
                    onboardingProvider.goToPreviousQuestion();
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),

            ///Body
            body: SafeArea(
              child: PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(), // Disable manual swiping
                pageSnapping: false,
              itemCount: onboardingProvider.currentQuestions.length,
              onPageChanged: (index) {
                onboardingProvider.setCurrentQuestionIndex(index);
              },
              itemBuilder: (context, index) {
                final question = onboardingProvider.currentQuestions[index];
                final questionKey =
                    onboardingProvider.getQuestionKey(question.questionText);

                return Container(
                  key: ValueKey(index),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    gradient: onboardingProvider.currentQuestionIndex == 4
                        ? LinearGradient(
                            colors: [
                              AppColors.c0000ff,
                              AppColors.c5454FF,
                              AppColors.c95C5FA,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,
                  ),
                  child: Column(
                    spacing: 10.h,
                    children: [
                      CustomProgressBar(
                        currentStep: index + 1,
                        totalSteps: onboardingProvider.currentQuestions.length,
                        height: 14.h,
                        backgroundColor: AppColors.cE6E8ED,
                        gradientColors: [
                          AppColors.c3B13CA,
                          AppColors.c0000ff,
                          AppColors.c5454FF,
                        ],
                      ),
                      question.questionText
                                  .contains("Do you wanna lose weight") ||
                              question.questionText.contains(
                                  "Do you want to get an attractive body?")
                          ? SizedBox.shrink()
                          : Text(
                              question.questionText,
                              style: TextStyle(
                                color: AppColors.c000000,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                                fontSize: 28.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (question.questionImage != null)
                            Flexible(
                              child: Center(
                                child: Image.asset(
                                  question.questionImage!,
                                  key: ValueKey(
                                      '${question.questionImage}_${onboardingProvider.currentQuestionIndex}'),
                                  width: question.questionImage ==
                                          Assets.images.a145LbsByOct17.path
                                      ? 330.w
                                      : onboardingProvider
                                                  .currentQuestionIndex ==
                                              4
                                          ? 260.w
                                          : question.questionText
                                                      .contains("3,676,490") ||
                                                  question.questionText
                                                      .contains(
                                                          "statement below") ||
                                                  question.questionText
                                                      .contains(
                                                          "just like you") ||
                                                  question.questionText
                                                      .contains(
                                                          "attractive body")
                                              ? .85.sw
                                              : null,
                                  height: question.questionType ==
                                          QuestionType.yesNo
                                      ? 0.45.sh
                                      : question.questionText
                                              .contains("3,676,490")
                                          ? 0.5.sh
                                          : 0.55.sh,
                                  fit: question.questionImage ==
                                          Assets.images.a145LbsByOct17.path
                                      ? BoxFit.cover
                                      : BoxFit.contain,
                                ),
                              ),
                            ),

                          if (question.questionType == QuestionType.slider &&
                              question.options.isNotEmpty)
                            Builder(builder: (context) {
                              final questionKey = onboardingProvider
                                  .getQuestionKey(question.questionText);
                              final options = question.options;
                              double currentIndex = 0;
                              final saved =
                                  onboardingProvider.responses[questionKey];
                              if (saved != null) {
                                final idx = int.tryParse(saved);
                                if (idx != null) {
                                  currentIndex = idx.toDouble();
                                } else {
                                  final found = options
                                      .indexWhere((o) => o.optionText == saved);
                                  if (found >= 0) {
                                    currentIndex = found.toDouble();
                                  }
                                }
                              }
                              final isBodyType = question.questionText
                                  .toLowerCase()
                                  .contains('body type');
                              return Column(
                                children: [
                                  if (options[currentIndex.toInt()]
                                          .optionImage !=
                                      null)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: Image.asset(
                                        options[currentIndex.toInt()]
                                            .optionImage!,
                                        height: 350.h,
                                        width: 300.w,
                                      ),
                                    ),
                                  Container(
                                    height: 30.h,
                                    width: 0.8.sw,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.c0000ff
                                          .withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(8.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(options.length,
                                          (index) {
                                        final isSelected =
                                            index == currentIndex.toInt();
                                        return GestureDetector(
                                          onTap: () {
                                            onboardingProvider.setTextInput(
                                                index.toString(), questionKey);
                                          },
                                          child: Container(
                                            width: 16.w,
                                            height: 16.w,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.c0000ff
                                                  : AppColors.cE6E8ED,
                                              shape: BoxShape.circle,
                                              border: isSelected
                                                  ? Border.all(
                                                      color: AppColors.c0000ff,
                                                      width: 2,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    width: .8.sw,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          isBodyType
                                              ? "Cut"
                                              : options.first.optionText,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.c000000,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          isBodyType
                                              ? "Extra"
                                              : options.last.optionText,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.c000000,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),

                          // Handle different question types
                          if (question.questionType == QuestionType.textInput)
                            Expanded(
                              child: Column(
                                spacing: 10.h,
                                children: [
                                  CustomFormField(
                                    controller: _getController(
                                      questionKey,
                                      onboardingProvider
                                              .responses[questionKey] ??
                                          '',
                                    ),
                                    onChanged: (value) {
                                      onboardingProvider.setTextInput(
                                          value, questionKey);
                                    },
                                    style: TextStyle(
                                      color: AppColors.c000000,
                                      fontFamily: "Inter",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    fillColor: AppColors.c0000ff
                                        .withValues(alpha: 0.05),
                                    borderRadius: 10.r,
                                  ),
                                ],
                              ),
                            ),
                          if (question.questionType == QuestionType.numberInput)
                            Expanded(
                              child: Column(
                                spacing: 20.h,
                                children: [
                                  if (question.options.isNotEmpty)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: question.options.map((option) {
                                        final defaultUnit = question
                                                .questionText
                                                .contains('height')
                                            ? 'ft'
                                            : (question.questionText
                                                    .contains('weight')
                                                ? 'lbs'
                                                : null);
                                        final currentUnit = onboardingProvider
                                                .selectedOptionForCurrentQuestion ??
                                            defaultUnit;
                                        final isSelected =
                                            currentUnit == option.optionText;
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: CustomCard(
                                            onTap: () {
                                              if (question.questionText
                                                  .contains('weight')) {
                                                onboardingProvider.updateUnit(
                                                    option.optionText,
                                                    questionKey);
                                              } else {
                                                onboardingProvider.selectOption(
                                                    option.optionText,
                                                    questionKey);
                                              }
                                            },
                                            width: 80.w,
                                            height: 40.h,
                                            color: isSelected
                                                ? AppColors.c0000ff
                                                : AppColors.cE6E8ED,
                                            child: Center(
                                              child: Text(
                                                option.optionText,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : AppColors.c000000,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  if (question.questionText.contains("height"))
                                    Builder(
                                      builder: (context) {
                                        final selectedUnit = onboardingProvider
                                                .selectedOptionForCurrentQuestion ??
                                            'ft';
                                        if (selectedUnit == 'ft') {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            spacing: 16.w,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    CustomFormField(
                                                      controller:
                                                          _getController(
                                                        "${questionKey}_ft",
                                                        onboardingProvider
                                                                    .responses[
                                                                "${questionKey}_ft"] ??
                                                            '',
                                                      ),
                                                      inputType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        onboardingProvider
                                                            .setTextInput(value,
                                                                "${questionKey}_ft",
                                                                affectSelection:
                                                                    false);
                                                        onboardingProvider
                                                            .updateCombinedHeight(
                                                                questionKey);
                                                      },
                                                      suffixIcon: Text("'",
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: AppColors
                                                                  .c000000)),
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.c000000,
                                                        fontFamily: "Inter",
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      fillColor: AppColors
                                                          .c0000ff
                                                          .withValues(
                                                              alpha: 0.05),
                                                      borderRadius: 10.r,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    CustomFormField(
                                                      controller:
                                                          _getController(
                                                        "${questionKey}_in",
                                                        onboardingProvider
                                                                    .responses[
                                                                "${questionKey}_in"] ??
                                                            '',
                                                      ),
                                                      inputType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        onboardingProvider
                                                            .setTextInput(value,
                                                                "${questionKey}_in",
                                                                affectSelection:
                                                                    false);
                                                        onboardingProvider
                                                            .updateCombinedHeight(
                                                                questionKey);
                                                      },
                                                      suffixIcon: Text('"',
                                                          style: TextStyle(
                                                              fontSize: 28.sp,
                                                              color: AppColors
                                                                  .c000000)),
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.c000000,
                                                        fontFamily: "Inter",
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      fillColor: AppColors
                                                          .c0000ff
                                                          .withValues(
                                                              alpha: 0.05),
                                                      borderRadius: 10.r,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return CustomFormField(
                                            controller: _getController(
                                              "${questionKey}_cm",
                                              onboardingProvider.responses[
                                                      "${questionKey}_cm"] ??
                                                  '',
                                            ),
                                            inputType: TextInputType.number,
                                            onChanged: (value) {
                                              onboardingProvider.setTextInput(
                                                  value, "${questionKey}_cm",
                                                  affectSelection: false);
                                              onboardingProvider
                                                  .updateCombinedHeight(
                                                      questionKey);
                                            },
                                            style: TextStyle(
                                              color: AppColors.c000000,
                                              fontFamily: "Inter",
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            fillColor: AppColors.c0000ff
                                                .withValues(alpha: 0.05),
                                            borderRadius: 10.r,
                                          );
                                        }
                                      },
                                    ),
                                  if (!question.questionText
                                          .contains("height") &&
                                      question.questionText.contains("weight"))
                                    CustomFormField(
                                      controller: () {
                                        final storedValue = onboardingProvider
                                                .responses[questionKey] ??
                                            '';
                                        // Extract just the numeric part if it has a unit suffix
                                        final numericValue =
                                            storedValue.replaceAll(
                                                RegExp(r'[^0-9\.]'), '');
                                        return _getController(
                                          "${questionKey}_weight",
                                          numericValue,
                                        );
                                      }(),
                                      inputType: TextInputType.number,
                                      onChanged: (value) {
                                        onboardingProvider.updateWeight(
                                            questionKey, value);
                                      },
                                      style: TextStyle(
                                        color: AppColors.c000000,
                                        fontFamily: "Inter",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      fillColor: AppColors.c0000ff
                                          .withValues(alpha: 0.05),
                                      borderRadius: 10.r,
                                    ),
                                  if (!question.questionText
                                          .contains("height") &&
                                      !question.questionText.contains("weight"))
                                    CustomFormField(
                                      controller: _getController(
                                        "${questionKey}_number",
                                        onboardingProvider
                                                .responses[questionKey] ??
                                            '',
                                      ),
                                      inputType: TextInputType.number,
                                      onChanged: (value) {
                                        onboardingProvider.setTextInput(
                                            value, questionKey);
                                      },
                                      style: TextStyle(
                                        color: AppColors.c000000,
                                        fontFamily: "Inter",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      fillColor: AppColors.c0000ff
                                          .withValues(alpha: 0.05),
                                      borderRadius: 10.r,
                                    ),
                                ],
                              ),
                            ),
                          if (question.options.isNotEmpty &&
                              question.questionType !=
                                  QuestionType.numberInput &&
                              question.questionType != QuestionType.textInput &&
                              question.questionType != QuestionType.slider &&
                              question.questionType != QuestionType.yesNo)
                            Expanded(
                              child: Column(
                                spacing: 20.h,
                                children: [
                                  ...question.options.map((option) {
                                    // Use provider.responses to determine selected
                                    final selectedValue = onboardingProvider
                                        .responses[questionKey];
                                    final isSelected =
                                        selectedValue == option.optionText;
                                    return CustomCard(
                                      onTap: () {
                                        onboardingProvider.selectOption(
                                            option.optionText, questionKey);
                                      },
                                      height: 70.h,
                                      color: AppColors.c0000ff.withValues(
                                        alpha: isSelected ? 1.0 : 0.05,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                                              child: Text(
                                                option.optionText,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : AppColors.c000000,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 22.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          option.optionImage != null
                                              ? Expanded(
                                                  child: Image.asset(
                                                    option.optionImage!,
                                                    height: 70.h,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                        ],
                      ),
                      if (question.questionText
                          .contains("Upload Your Body Photo.")) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              spacing: 10.h,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await imagePickerProvider
                                        .pickImageFromCamera();
                                    // If image picked, save path to onboarding responses
                                    if (imagePickerProvider.selectedImage !=
                                        null) {
                                      onboardingProvider.setTextInput(
                                          imagePickerProvider
                                              .selectedImage!.path,
                                          'body_image',
                                          affectSelection: false);
                                    }
                                  },
                                  child: CustomContainer(
                                    width: .3.sw,
                                    height: .3.sw,
                                    child: imagePickerProvider.isFromCamera ==
                                                true &&
                                            imagePickerProvider.selectedImage !=
                                                null
                                        ? Image.file(
                                            imagePickerProvider.selectedImage!,
                                            key: ValueKey(
                                                'camera_${imagePickerProvider.selectedImage!.path}_${onboardingProvider.currentQuestionIndex}'),
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.camera_alt,
                                            size: 50.sp,
                                            color: AppColors.c0000ff),
                                  ),
                                ),
                                Text(
                                  "Take a New Photo",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.c000000,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              spacing: 10.h,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await imagePickerProvider
                                        .pickImageFromGallery();
                                    if (imagePickerProvider.selectedImage !=
                                        null) {
                                      onboardingProvider.setTextInput(
                                          imagePickerProvider
                                              .selectedImage!.path,
                                          'body_image',
                                          affectSelection: false);
                                    }
                                  },
                                  child: CustomContainer(
                                    width: .3.sw,
                                    height: .3.sw,
                                    child: (imagePickerProvider.isFromCamera ==
                                                false &&
                                            imagePickerProvider.selectedImage !=
                                                null)
                                        ? Image.file(
                                            imagePickerProvider.selectedImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.photo_library,
                                            size: 50.sp,
                                            color: AppColors.c0000ff),
                                  ),
                                ),
                                Text(
                                  "Upload from Gallery",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.c000000,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.c000000,
                                ),
                                children: [
                                  TextSpan(
                                    text: "1,000,000",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.c0000ff,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "+ FitSnap AI users\n\n",
                                  ),
                                  TextSpan(
                                      text: "87% of FitSnap AI users",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ))
                                ]))
                      ],
                      if (question.questionType == QuestionType.yesNo &&
                          question.options.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomElevatedButton(
                              buttonTitle: "Yes",
                              buttonWidth: 120.w,
                              buttonColor: onboardingProvider
                                          .responses[questionKey] ==
                                      "Yes"
                                  ? AppColors.c0000ff
                                  : AppColors.c0000ff.withValues(alpha: 0.05),
                              onTap: () {
                                onboardingProvider.setTextInput(
                                    "Yes", questionKey);
                              },
                            ),
                            CustomElevatedButton(
                              buttonTitle: "No",
                              buttonWidth: 120.w,
                              buttonColor: onboardingProvider
                                          .responses[questionKey] ==
                                      "No"
                                  ? AppColors.c0000ff
                                  : AppColors.c0000ff.withValues(alpha: 0.05),
                              onTap: () {
                                onboardingProvider.setTextInput(
                                    "No", questionKey);
                              },
                            ),
                          ],
                        ),
                      // BMI Card for current weight questions
                      if (onboardingProvider.bmi != null &&
                          question.questionText.contains("current weight")) ...[
                        UIHelper.verticalSpaceExtraLarge,
                        UIHelper.verticalSpaceLarge,
                        CustomContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Your BMI:',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.c000000,
                                  )),
                              SizedBox(height: 4.h),
                              Text(
                                onboardingProvider.bmi!.toStringAsFixed(2),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                  color: Colors.redAccent,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                _bmiAdvice(onboardingProvider.bmiCategory),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.c000000,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      // Reasonable Goal Card for target weight questions
                      if (question.questionText.contains("target weight") &&
                          onboardingProvider
                                  .responses[questionKey]?.isNotEmpty ==
                              true) ...[
                        UIHelper.verticalSpaceExtraLarge,
                        UIHelper.verticalSpaceLarge,
                        CustomContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reasonable Goal',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: Colors.redAccent,
                                  )),
                              SizedBox(height: 8.h),
                              Text(
                                _getReasonableGoalText(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.c000000,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      // if (question.questionType != QuestionType.yesNo) Spacer(),
                      // Show continue button only when an option is selected
                      if (onboardingProvider.hasSelectedOption ||
                          onboardingProvider.currentQuestionIndex == 4 ||
                          question.questionText.contains("just like you") ||
                          question.questionText.contains("3,676,490") ||
                          question.questionImage ==
                              Assets.images.a145LbsByOct17.path ||
                          (question.questionType == QuestionType.textInput &&
                              onboardingProvider
                                      .responses[questionKey]?.isNotEmpty ==
                                  true) ||
                          (question.questionType == QuestionType.numberInput &&
                              onboardingProvider
                                      .responses[questionKey]?.isNotEmpty ==
                                  true) ||
                          imagePickerProvider.selectedImage != null)
                        CustomElevatedButton(
                          buttonTitle: "Continue",
                          onTap: () {
                            // Check if this is the last question
                            if (onboardingProvider.currentQuestionIndex ==
                                onboardingProvider.currentQuestions.length -
                                    1) {
                              // Complete onboarding and navigate to plan intro screen
                              onboardingProvider
                                  .completeOnboarding()
                                  .then(((value) {
                                if (value) {
                                  NavigationService.navigateTo(
                                    Routes.planIntroScreen,
                                  );
                                }
                              }));
                            } else {
                              // Continue to next question
                              onboardingProvider.goToNextQuestion();
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      // UIHelper.verticalSpaceMedium,
                    ],
                  ),
                );
              },
              ),
            ),
          ),
        );
      },
    );
  }

  String _bmiAdvice(String? category) {
    switch (category) {
      case 'Underweight':
        return "You're a little under – healthy gain is achievable.";
      case 'Normal':
        return "Great! Just a little more, your top form is near.";
      case 'Overweight':
        return "Just a little more reset, your right shape is around the corner.";
      case 'Obese':
        return "Reasonable goal: 5–10% loss improves key health markers.";
      default:
        return '';
    }
  }

  String _getReasonableGoalText() {
    return "You will lose 15% of your weight; there is scientific evidence that some obesity-related conditions improve with 5% or higher weight loss.";
  }
}