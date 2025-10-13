import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:fitai/features/ai_cam/presentation/ai_cam_screen.dart';
import 'package:fitai/features/explore/presentation/explore_screen.dart';
import 'package:fitai/features/meal/presentation/meal_screen.dart';
import 'package:fitai/features/my_plan/presentation/progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'features/workouts/presentation/workouts_screen.dart';
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
          const ProgressScreen(),
          const WorkoutsScreen(),
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
                selectedColor: AppColors.c0000ff,
                strokeColor: Colors.transparent,
                unSelectedColor: Colors.black54,
                borderRadius: Radius.zero,
                items: [
                  CustomNavigationBarItem(
                    icon: Icon(
                      Icons.show_chart,
                      color: currentIndex == 0
                          ? AppColors.c0000ff
                          : Colors.black54,
                    ),
                    title: Text(
                      "Progress",
                      style: TextStyle(
                          color: currentIndex == 0
                              ? AppColors.c0000ff
                              : Colors.black54),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Icon(
                      Icons.fitness_center,
                      color: currentIndex == 1
                          ? AppColors.c0000ff
                          : Colors.black54,
                    ),
                    title: Text(
                      "My Plan",
                      style: TextStyle(
                          color: currentIndex == 1
                              ? AppColors.c0000ff
                              : Colors.black54),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Icon(
                      Icons.camera_alt,
                      color: currentIndex == 2
                          ? AppColors.c0000ff
                          : Colors.black54,
                    ),
                    title: Text(
                      "AI Cam",
                      style: TextStyle(
                          color: currentIndex == 2
                              ? AppColors.c0000ff
                              : Colors.black54),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Icon(
                      Icons.restaurant,
                      color: currentIndex == 3
                          ? AppColors.c0000ff
                          : Colors.black54,
                    ),
                    title: Text(
                      "Meal",
                      style: TextStyle(
                          color: currentIndex == 3
                              ? AppColors.c0000ff
                              : Colors.black54),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: Icon(
                      Icons.explore,
                      color: currentIndex == 4
                          ? AppColors.c0000ff
                          : Colors.black54,
                    ),
                    title: Text(
                      "Workouts",
                      style: TextStyle(
                          color: currentIndex == 4
                              ? AppColors.c0000ff
                              : Colors.black54),
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
