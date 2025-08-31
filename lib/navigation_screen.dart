import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:fitsnap_ai/features/ai_cam/presentation/ai_cam_screen.dart';
import 'package:fitsnap_ai/features/ceckout/presentation/checkout_screen.dart';
import 'package:fitsnap_ai/features/explore/presentation/explore_screen.dart';
import 'package:fitsnap_ai/features/meal/presentation/meal_screen.dart';
import 'package:fitsnap_ai/features/my_plan/presentation/my_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'customer/bookings/presentation/bookings_screen.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';
import 'provider/navigation_provider.dart';

class NavigationScreen extends StatelessWidget {
  final Widget? pageNum;
  const NavigationScreen({
    super.key,
    this.pageNum,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        final int currentIndex = navigationProvider.currentIndex;

        final List<Widget> screens = [
          const MyPlanScreen(),
          const BookingsScreen(),
          const AiCamScreen(),
          const MealScreen(),
          const ExploreScreen(),
        ];

        return Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          body: Center(
            child: screens.elementAt(currentIndex),
          ),
          bottomNavigationBar: Container(
            height: 66.h,
            decoration: BoxDecoration(
              color: AppColors.c02BF65,
            ),
            child: Padding(
              padding: EdgeInsets.all(0.sp),
              child: CustomNavigationBar(
                iconSize: 28.r,
                selectedColor: Colors.red,
                strokeColor: AppColors.c012d4d,
                unSelectedColor: AppColors.c6b7280,
                borderRadius: Radius.zero,
                items: [
                  CustomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        currentIndex == 0
                            ? Container(
                                height: 60.h,
                                width: 60.w,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(6.sp),
                                child: Image.asset(
                                  Assets.icons.bottomNavMyPlanIcon.path,
                                  color: AppColors.c012d4d,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                    Assets.icons.bottomNavMyPlanIcon.path,
                                    color: AppColors.c6b7280),
                              ),
                      ],
                    ),
                    title: Text(
                      "My Plan",
                      style: TextStyle(
                          color: currentIndex == 0
                              ? AppColors.c012d4d
                              : AppColors.c6b7280),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        currentIndex == 1
                            ? Container(
                                height: 50.h,
                                width: 50.w,
                                padding: EdgeInsets.all(6.sp),
                                child: Image.asset(
                                  Assets.icons.bottomNavExerciseIcon.path,
                                  color: AppColors.c012d4d,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                    Assets.icons.bottomNavExerciseIcon.path,
                                    height: 25.h,
                                    color: AppColors.c6b7280),
                              ),
                      ],
                    ),
                    title: Text(
                      "Workouts",
                      style: TextStyle(
                          color: currentIndex == 1
                              ? AppColors.c012d4d
                              : AppColors.c6b7280),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        currentIndex == 2
                            ? Container(
                                height: 50.h,
                                width: 50.w,
                                padding: EdgeInsets.all(4.sp),
                                child: Image.asset(
                                  Assets.icons.bottomNavAiCamIcon.path,
                                  color: AppColors.c012d4d,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                    Assets.icons.bottomNavAiCamIcon.path,
                                    color: AppColors.c6b7280),
                              ),
                      ],
                    ),
                    title: Text(
                      "AI Cam",
                      style: TextStyle(
                          color: currentIndex == 2
                              ? AppColors.c012d4d
                              : AppColors.c6b7280),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        currentIndex == 3
                            ? Container(
                                height: 50.h,
                                width: 50.w,
                                padding: EdgeInsets.all(4.sp),
                                child: Image.asset(
                                  Assets.icons.bottomNavMealIcon.path,
                                  color: AppColors.c012d4d,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                    Assets.icons.bottomNavMealIcon.path,
                                    color: AppColors.c6b7280),
                              ),
                      ],
                    ),
                    title: Text(
                      "Meal",
                      style: TextStyle(
                          color: currentIndex == 3
                              ? AppColors.c012d4d
                              : AppColors.c6b7280),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        currentIndex == 4
                            ? Container(
                                height: 50.h,
                                width: 50.w,
                                padding: EdgeInsets.all(4.sp),
                                child: Image.asset(
                                  Assets.icons.bottomNavExploreIcon.path,
                                  color: AppColors.c012d4d,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                    Assets.icons.bottomNavExploreIcon.path,
                                    color: AppColors.c6b7280),
                              ),
                      ],
                    ),
                    title: Text(
                      "Explore",
                      style: TextStyle(
                          color: currentIndex == 4
                              ? AppColors.c012d4d
                              : AppColors.c6b7280),
                    ),
                  ),
                ],
                currentIndex: currentIndex,
                onTap: (index) {
                  navigationProvider.setIndex(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
