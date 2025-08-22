import 'package:fitsnap_ai/common_widgets/custom_card.dart';
import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/impage_picker_provider_fitsnap.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../../helpers/navigation_service.dart';
import 'models/onboarding_model.dart';
import 'providers/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<OnboardingProvider, ImagePickerProviderFitsnap>(
      builder: (context, onboardingProvider, imagePickerProvider, child) {
        return Scaffold(
          ///AppBar
          appBar: AppBar(
            backgroundColor: onboardingProvider.currentQuestionIndex == 4
                ? AppColors.c0000ff
                : Color(0xFFFFFFFF),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                // NavigationService.goBack();
                if (onboardingProvider.currentQuestionIndex > 0) {
                  onboardingProvider.goToPreviousQuestion();
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  NavigationService.goBack();
                }
              },
            ),
          ),

          ///Body
          body: PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // Disable manual swiping
            itemCount: onboardingProvider.currentQuestions.length,
            onPageChanged: (index) {
              onboardingProvider.setCurrentQuestionIndex(index);
            },
            itemBuilder: (context, index) {
              final question = onboardingProvider.currentQuestions[index];
              final questionKey =
                  onboardingProvider.getQuestionKey(question.questionText);

              return Container(
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
                  spacing: 20.h,
                  children: [
                    LinearProgressIndicator(
                      value: (index + 1) /
                          onboardingProvider.currentQuestions.length,
                      minHeight: 14.h,
                      backgroundColor: AppColors.cE6E8ED,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.c3B13CA),
                    ),
                    Text(
                      question.questionText,
                      style: TextStyle(
                        color: AppColors.c000000,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 30.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (question.questionImage != null)
                          Center(
                            child: Image.asset(
                              question.questionImage!,
                              width: question.questionImage ==
                                      Assets.images.a145LbsByOct17.path
                                  ? 330.w
                                  : onboardingProvider.currentQuestionIndex == 4
                                      ? 260.w
                                      : question.questionText
                                                  .contains("3,676,490") ||
                                              question.questionText.contains(
                                                  "statement below") ||
                                              question.questionText
                                                  .contains("just like you") ||
                                              question.questionText.isEmpty
                                          ? .85.sw
                                          : null,
                              fit: question.questionImage ==
                                      Assets.images.a145LbsByOct17.path
                                  ? BoxFit.cover
                                  : BoxFit.contain,
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
                                // Show option image above the dots, if present
                                if (options[currentIndex.toInt()].optionImage !=
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
                                // Dots row container
                                Container(
                                  height: 30.h,
                                  width: 0.8.sw,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.c0000ff
                                        .withValues(alpha: 0.11),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children:
                                        List.generate(options.length, (index) {
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
                                // First and last option text below the container
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
                              spacing: 20.h,
                              children: [
                                CustomFormField(
                                  onChanged: (value) {
                                    onboardingProvider.setTextInput(
                                        value, questionKey);
                                  },
                                  style: TextStyle(
                                    color: AppColors.c000000,
                                    fontFamily: "Inter",
                                    fontSize: 18.sp,
                                  ),
                                  fillColor:
                                      AppColors.c0000ff.withValues(alpha: 0.11),
                                ),
                              ],
                            ),
                          ),
                        if (question.questionType == QuestionType.numberInput)
                          Expanded(
                            child: Column(
                              spacing: 20.h,
                              children: [
                                // Unit toggle buttons
                                if (question.options.isNotEmpty)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: question.options.map((option) {
                                      // For height default to ft only if no user selection yet
                                      final defaultUnit = question.questionText
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
                                            onboardingProvider.selectOption(
                                                option.optionText, questionKey);
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
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                // Height input: show two fields for ft, one for cm
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
                                            // Feet field
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  CustomFormField(
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
                                                      color: AppColors.c000000,
                                                      fontFamily: "Inter",
                                                      fontSize: 22.sp,
                                                    ),
                                                    fillColor: AppColors.c0000ff
                                                        .withValues(
                                                            alpha: 0.11),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Inches field
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  CustomFormField(
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
                                                      color: AppColors.c000000,
                                                      fontFamily: "Inter",
                                                      fontSize: 22.sp,
                                                    ),
                                                    fillColor: AppColors.c0000ff
                                                        .withValues(
                                                            alpha: 0.11),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        // cm field
                                        return CustomFormField(
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
                                          ),
                                          fillColor: AppColors.c0000ff
                                              .withValues(alpha: 0.11),
                                        );
                                      }
                                    },
                                  ),
                                // Weight input (current / target weight). Do NOT change unit selection when typing.
                                if (!question.questionText.contains("height") &&
                                    question.questionText.contains("weight"))
                                  CustomFormField(
                                    inputType: TextInputType.number,
                                    onChanged: (value) {
                                      onboardingProvider.updateWeight(
                                          questionKey, value);
                                    },
                                    style: TextStyle(
                                      color: AppColors.c000000,
                                      fontFamily: "Inter",
                                      fontSize: 18.sp,
                                    ),
                                    fillColor: AppColors.c0000ff
                                        .withValues(alpha: 0.11),
                                  ),
                                // Slider type (custom styled to match screenshot)
                                // Generic number input fallback
                                if (!question.questionText.contains("height") &&
                                    !question.questionText.contains("weight"))
                                  CustomFormField(
                                    inputType: TextInputType.number,
                                    onChanged: (value) {
                                      onboardingProvider.setTextInput(
                                          value, questionKey);
                                    },
                                    style: TextStyle(
                                      color: AppColors.c000000,
                                      fontFamily: "Inter",
                                      fontSize: 18.sp,
                                    ),
                                    fillColor: AppColors.c0000ff
                                        .withValues(alpha: 0.11),
                                  ),
                              ],
                            ),
                          ),
                        if (question.options.isNotEmpty &&
                            question.questionType != QuestionType.numberInput &&
                            question.questionType != QuestionType.textInput &&
                            question.questionType != QuestionType.slider &&
                            question.questionType != QuestionType.yesNo)
                          Expanded(
                            child: Column(
                              spacing: 20.h,
                              children: [
                                ...question.options.map((option) {
                                  final isSelected = onboardingProvider
                                          .selectedOptionForCurrentQuestion ==
                                      option.optionText;
                                  return CustomCard(
                                    onTap: () {
                                      onboardingProvider.selectOption(
                                          option.optionText, questionKey);
                                    },
                                    // width: double.infinity,
                                    height: 70.h,
                                    color: AppColors.c0000ff.withValues(
                                      alpha: isSelected ? 1.0 : 0.11,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            option.optionText,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColors.c000000,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25.sp,
                                            ),
                                          ),
                                        ),
                                        option.optionImage != null
                                            ? Expanded(
                                                child: Image.asset(
                                                  option.optionImage!,
                                                  // width: 40.w,
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
                                  fontWeight: FontWeight.bold,
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
                                },
                                child: CustomContainer(
                                  width: .3.sw,
                                  height: .3.sw,
                                  child: (imagePickerProvider.isFromCamera ==
                                              true &&
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      UIHelper.verticalSpaceLarge,
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.c000000,
                              ),
                              children: [
                                TextSpan(
                                  text: "1000000",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.c0000ff,
                                  ),
                                ),
                                TextSpan(
                                  text: "+FitSnap AI users\n\n\n",
                                ),
                                TextSpan(
                                    text: "87% of FitSnap AI users",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]))
                    ],
                    if (question.questionType == QuestionType.yesNo &&
                        question.options.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Yes button
                          CustomElevatedButton(
                            buttonTitle: "Yes",
                            buttonWidth: 100.w,
                            buttonColor:
                                onboardingProvider.responses[questionKey] ==
                                        "Yes"
                                    ? AppColors.c0000ff
                                    : AppColors.c0000ff.withValues(alpha: 0.11),
                            onTap: () {
                              onboardingProvider.setTextInput(
                                  "Yes", questionKey);
                            },
                          ),
                          // No button
                          CustomElevatedButton(
                            buttonTitle: "No",
                            buttonWidth: 100.w,
                            buttonColor:
                                onboardingProvider.responses[questionKey] ==
                                        "No"
                                    ? AppColors.c0000ff
                                    : AppColors.c0000ff.withValues(alpha: 0.11),
                            onTap: () {
                              onboardingProvider.setTextInput(
                                  "No", questionKey);
                            },
                          ),
                        ],
                      ),
                    if (onboardingProvider.bmi != null &&
                        question.questionText.contains("weight")) ...[
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (question.questionType != QuestionType.yesNo) Spacer(),
                    // UIHelper.verticalSpaceExtraLarge,
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
                          onboardingProvider.goToNextQuestion();
                          if (onboardingProvider.currentQuestionIndex <
                              onboardingProvider.currentQuestions.length) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    UIHelper.verticalSpaceMedium,
                  ],
                ),
              );
            },
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
}
