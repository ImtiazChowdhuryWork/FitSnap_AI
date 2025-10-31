import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Helper class for responsive design across different screen sizes
/// Provides utilities for font sizing, spacing, padding, and screen type detection
class ResponsiveHelper {
  // Screen size detection
  static bool isSmallScreen(BuildContext context) => 
      MediaQuery.of(context).size.width < 360;
  
  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < 768;
  
  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= 768 && 
      MediaQuery.of(context).size.width < 1024;
  
  static bool isDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= 1024;
  
  /// Responsive font scaling based on screen size
  /// 
  /// [baseSize] - The base font size that will be scaled
  /// Returns scaled font size using ScreenUtil
  static double fontSize(BuildContext context, double baseSize) {
    if (isSmallScreen(context)) return (baseSize * 0.85).sp;
    if (isTablet(context)) return (baseSize * 1.1).sp;
    if (isDesktop(context)) return (baseSize * 1.2).sp;
    return baseSize.sp;
  }
  
  /// Responsive spacing/height scaling based on screen size
  /// 
  /// [baseSpacing] - The base spacing value that will be scaled
  /// Returns scaled spacing using ScreenUtil
  static double spacing(BuildContext context, double baseSpacing) {
    if (isSmallScreen(context)) return (baseSpacing * 0.8).h;
    if (isTablet(context)) return (baseSpacing * 1.2).h;
    if (isDesktop(context)) return (baseSpacing * 1.5).h;
    return baseSpacing.h;
  }
  
  /// Responsive padding based on screen size
  /// 
  /// [horizontal] - Base horizontal padding value
  /// [vertical] - Base vertical padding value
  /// Returns EdgeInsets with scaled padding
  static EdgeInsets padding(BuildContext context, double horizontal, double vertical) {
    final hPad = isSmallScreen(context) ? horizontal * 0.7 : 
               isTablet(context) ? horizontal * 1.2 : 
               isDesktop(context) ? horizontal * 1.5 : horizontal;
    final vPad = isSmallScreen(context) ? vertical * 0.8 : 
               isTablet(context) ? vertical * 1.1 : 
               isDesktop(context) ? vertical * 1.3 : vertical;
    return EdgeInsets.symmetric(horizontal: hPad.w, vertical: vPad.h);
  }
  
  /// Maximum content width for larger screens
  /// Prevents content from stretching too wide on tablets and desktops
  /// 
  /// Returns appropriate max width based on screen size
  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 600.w;
    if (isTablet(context)) return MediaQuery.of(context).size.width * 0.8;
    return MediaQuery.of(context).size.width;
  }
}
