import 'package:fitai/gen/assets.gen.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fitai/common_widgets/custom_text_form_field.dart';
import '../models/onboarding_model.dart';
import '../providers/onboarding_provider.dart';
import '../../../../provider/image_picker_provider.dart';

// Responsive Helper Class
class ResponsiveHelper {
  static bool isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 360;
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
  
  // Responsive font scaling
  static double fontSize(BuildContext context, double baseSize) {
    if (isSmallScreen(context)) return (baseSize * 0.85).sp;
    if (isTablet(context)) return (baseSize * 1.1).sp;
    if (isDesktop(context)) return (baseSize * 1.2).sp;
    return baseSize.sp;
  }
  
  // Responsive spacing
  static double spacing(BuildContext context, double baseSpacing) {
    if (isSmallScreen(context)) return (baseSpacing * 0.8).h;
    if (isTablet(context)) return (baseSpacing * 1.2).h;
    if (isDesktop(context)) return (baseSpacing * 1.5).h;
    return baseSpacing.h;
  }
  
  // Responsive padding
  static EdgeInsets padding(BuildContext context, double horizontal, double vertical) {
    final hPad = isSmallScreen(context) ? horizontal * 0.7 : 
               isTablet(context) ? horizontal * 1.2 : 
               isDesktop(context) ? horizontal * 1.5 : horizontal;
    final vPad = isSmallScreen(context) ? vertical * 0.8 : 
               isTablet(context) ? vertical * 1.1 : 
               isDesktop(context) ? vertical * 1.3 : vertical;
    return EdgeInsets.symmetric(horizontal: hPad.w, vertical: vPad.h);
  }
  
  // Maximum content width for larger screens
  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 600.w;
    if (isTablet(context)) return MediaQuery.of(context).size.width * 0.8;
    return MediaQuery.of(context).size.width;
  }
}

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

    return SingleChildScrollView(
      child: Column(
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
                      fontSize: ResponsiveHelper.fontSize(context, 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveHelper.spacing(context, 8)),
          Text(
            "Step $currentStep of $totalSteps",
            style: TextStyle(
              color: AppColors.c000000,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveHelper.fontSize(context, 12),
            ),
          ),
        ],
      ),
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
          height: ResponsiveHelper.spacing(context, 50),
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
                fontSize: ResponsiveHelper.fontSize(context, 18),
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

                return SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top,
                    key: ValueKey(index),
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
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ResponsiveHelper.maxContentWidth(context),
                        ),
                        child: Container(
                          padding: ResponsiveHelper.padding(context, 20, 0),
                          child: Column(
                      spacing: ResponsiveHelper.spacing(context, 10),
                      children: [
                        CustomProgressBar(
                          currentStep: index + 1,
                          totalSteps: onboardingProvider.currentQuestions.length,
                          height: ResponsiveHelper.spacing(context, 14),
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
                                  fontSize: ResponsiveHelper.fontSize(context, 28),
                                ),
                                textAlign: TextAlign.center,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (question.questionImage != null)
                              Flexible(
                                child: Center(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Responsive image sizing
                                      double imageWidth;
                                      double imageHeight;
                                      
                                      if (ResponsiveHelper.isDesktop(context)) {
                                        imageWidth = constraints.maxWidth * 0.6;
                                        imageHeight = MediaQuery.of(context).size.height * 0.4;
                                      } else if (ResponsiveHelper.isTablet(context)) {
                                        imageWidth = constraints.maxWidth * 0.7;
                                        imageHeight = MediaQuery.of(context).size.height * 0.45;
                                      } else {
                                        // Mobile sizing (original logic)
                                        imageWidth = question.questionImage == Assets.images.a145LbsByOct17.path
                                            ? 330.w
                                            : onboardingProvider.currentQuestionIndex == 4
                                                ? 260.w
                                                : question.questionText.contains("3,676,490") ||
                                                        question.questionText.contains("statement below") ||
                                                        question.questionText.contains("just like you") ||
                                                        question.questionText.contains("attractive body")
                                                    ? 0.85.sw
                                                    : constraints.maxWidth * 0.8;
                                        
                                        imageHeight = question.questionType == QuestionType.yesNo
                                            ? 0.45.sh
                                            : question.questionText.contains("3,676,490")
                                                ? 0.5.sh
                                                : 0.55.sh;
                                      }
                                      
                                      return Image.asset(
                                        question.questionImage!,
                                        key: ValueKey('${question.questionImage}_${onboardingProvider.currentQuestionIndex}'),
                                        width: imageWidth,
                                        height: imageHeight,
                                        fit: question.questionImage == Assets.images.a145LbsByOct17.path
                                            ? BoxFit.cover
                                            : BoxFit.contain,
                                      );
                                    },
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
                                return SingleChildScrollView(
                                  child: Column(
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
                                  ),
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
                                      text: "+ FitAI users\n\n",
                                    ),
                                    TextSpan(
                                        text: "87% of FitAI users",
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
                                buttonWidth: ResponsiveHelper.isDesktop(context) ? 150.w : 120.w,
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
                                buttonWidth: ResponsiveHelper.isDesktop(context) ? 150.w : 120.w,
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
                          SizedBox(height: ResponsiveHelper.spacing(context, 16)),
                          Container(
                            width: double.infinity,
                            margin: ResponsiveHelper.padding(context, 16, 0),
                            padding: ResponsiveHelper.padding(context, 14, 14),
                            decoration: BoxDecoration(
                              color: AppColors.cFFFFFF,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.cE6E8ED,
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Your BMI',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: ResponsiveHelper.fontSize(context, 16),
                                          color: AppColors.c000000,
                                        )),
                                    Text(
                                      onboardingProvider.bmi!.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: ResponsiveHelper.fontSize(context, 28),
                                        color: AppColors.c0000ff,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: ResponsiveHelper.spacing(context, 10)),
                                Container(
                                  width: double.infinity,
                                  padding: ResponsiveHelper.padding(context, 10, 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.c0000ff.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    _bmiAdvice(onboardingProvider.bmiCategory),
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: ResponsiveHelper.fontSize(context, 14),
                                      color: AppColors.c000000,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Reasonable Goal Card for target weight questions
                        if (question.questionText.toLowerCase().contains("target weight") &&
                            onboardingProvider
                                    .responses[questionKey]?.isNotEmpty ==
                                true) ...[
                          SizedBox(height: ResponsiveHelper.spacing(context, 16)),
                          Container(
                            width: double.infinity,
                            margin: ResponsiveHelper.padding(context, 16, 0),
                            padding: ResponsiveHelper.padding(context, 14, 14),
                            decoration: BoxDecoration(
                              color: AppColors.cFFFFFF,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.cE6E8ED,
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.psychology_outlined,
                                      color: AppColors.c0000ff,
                                      size: ResponsiveHelper.fontSize(context, 20),
                                    ),
                                    SizedBox(width: ResponsiveHelper.spacing(context, 8)),
                                    Text('Reasonable Goal',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: ResponsiveHelper.fontSize(context, 16),
                                          color: AppColors.c000000,
                                        )),
                                  ],
                                ),
                                SizedBox(height: ResponsiveHelper.spacing(context, 12)),
                                Consumer<OnboardingProvider>(
                                  builder: (context, provider, child) {
                                    final goalText = _getReasonableGoalText(provider);
                                    final isGain = goalText.contains("gain");
                                    final isLoss = goalText.contains("lose");
                                    
                                    return Container(
                                      width: double.infinity,
                                      padding: ResponsiveHelper.padding(context, 12, 12),
                                      decoration: BoxDecoration(
                                        color: isGain 
                                            ? Colors.green.withOpacity(0.05)
                                            : isLoss 
                                                ? Colors.orange.withOpacity(0.05)
                                                : AppColors.c0000ff.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                          color: isGain 
                                              ? Colors.green.withOpacity(0.2)
                                              : isLoss 
                                                  ? Colors.orange.withOpacity(0.2)
                                                  : AppColors.c0000ff.withOpacity(0.2),
                                          width: 1.w,
                                        ),
                                      ),
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                              Icon(
                                            isGain 
                                                ? Icons.trending_up_rounded
                                                : isLoss 
                                                    ? Icons.trending_down_rounded
                                                    : Icons.trending_neutral_rounded,
                                            color: isGain 
                                                ? Colors.green
                                                : isLoss 
                                                    ? Colors.orange
                                                    : AppColors.c0000ff,
                                            size: ResponsiveHelper.fontSize(context, 18),
                                          ),
                                          SizedBox(width: ResponsiveHelper.spacing(context, 12)),
                                          Expanded(
                                            child: Text(
                                              goalText,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: ResponsiveHelper.fontSize(context, 14),
                                                color: AppColors.c000000,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
                        ),
                      ),
                    ),
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

  String _getReasonableGoalText(OnboardingProvider onboardingProvider) {
    
    // Use the same normalization approach as the provider's _find method
    String? findResponse(String canonical) {
      String normalize(String s) => s
          .toLowerCase()
          .replaceAll(RegExp(r"[''`\u2019]"), '')
          .replaceAll(RegExp(r"[^a-z0-9]"), '_')
          .replaceAll(RegExp(r"_+"), '_')
          .replaceAll(RegExp(r"^_|_"), '');

      final target = normalize(canonical);
      for (final entry in onboardingProvider.responses.entries) {
        if (normalize(entry.key) == target) return entry.value;
      }
      return null;
    }
    
    // Find current and target weight using the same approach as the provider
    final currentWeightStr = findResponse('whats_your_current_weight') ?? 
                            findResponse('what_is_your_current_weight') ?? '';
    final targetWeightStr = findResponse('whats_your_target_weight') ?? 
                           findResponse('target_weight') ?? '';
    
    // Parse weights and calculate percentage (remove units like 'kg', 'lbs')
    final currentWeight = double.tryParse(currentWeightStr.replaceAll(RegExp(r'[a-zA-Z\s]'), ''));
    final targetWeight = double.tryParse(targetWeightStr.replaceAll(RegExp(r'[a-zA-Z\s]'), ''));
    
    if (currentWeight != null && targetWeight != null && currentWeight > 0 && targetWeight > 0) {
      final percentage = ((currentWeight - targetWeight).abs() / currentWeight * 100).round();
      
      if (currentWeight > targetWeight) {
        // Weight loss scenario: current weight is higher than target
        return "You will lose $percentage% of your weight; there is scientific evidence that some obesity-related conditions improve with 5% or higher weight loss.";
      } else if (targetWeight > currentWeight) {
        // Weight gain scenario: target weight is higher than current
        return "You will gain $percentage% of your weight; this healthy weight gain can help improve muscle mass and overall strength.";
      } else {
        // Same weight - maintenance
        return "You want to maintain your current weight; this is great for maintaining your current fitness level and body composition.";
      }
    }
    
    // Fallback to static message if weights are not available
    return "You will work towards your weight goal; there is scientific evidence that healthy weight changes can improve overall health markers.";
  }
}
