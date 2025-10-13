import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widgets/custom_back_button.dart';
import '../../../gen/colors.gen.dart';
import '../../explore/presentation/widget/catched_video_player.dart';

import '../models/suggested_workouts_model.dart';

class DayWorkoutDetailsScreen extends StatefulWidget {
  final String day;
  final List<WorkoutDayItem> workouts;

  const DayWorkoutDetailsScreen({
    super.key,
    required this.day,
    required this.workouts,
  });

  @override
  State<DayWorkoutDetailsScreen> createState() => _DayWorkoutDetailsScreenState();
}

class _DayWorkoutDetailsScreenState extends State<DayWorkoutDetailsScreen> {
  int currentWorkoutIndex = 0;
  PageController pageController = PageController();
  bool isFullScreen = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });
  }

  void _exitFullScreen() {
    setState(() {
      isFullScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final validWorkouts = widget.workouts
        .where((w) => w.workout != null)
        .map((w) => w.workout!)
        .toList();

    if (validWorkouts.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text(widget.day),
        ),
        body: const Center(
          child: Text('No workouts available for this day'),
        ),
      );
    }

    // Full-screen video mode
    if (isFullScreen) {
      return _buildFullScreenVideo(validWorkouts[currentWorkoutIndex]);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              color: Colors.black,
              child: Row(
                children: [
                  const CustomBackButton(iconColor: Colors.white),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.day,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${currentWorkoutIndex + 1} of ${validWorkouts.length} exercises',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Progress indicator
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.c0000ff.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.c0000ff,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${((currentWorkoutIndex + 1) / validWorkouts.length * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.c0000ff,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar
            Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: LinearProgressIndicator(
                value: (currentWorkoutIndex + 1) / validWorkouts.length,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.c0000ff),
              ),
            ),

            SizedBox(height: 16.h),

            // Video content
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentWorkoutIndex = index;
                  });
                  log('Changed to workout ${index + 1}: ${validWorkouts[index].displayTitle}');
                },
                itemCount: validWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = validWorkouts[index];
                  return _buildWorkoutPage(workout, index);
                },
              ),
            ),

            // Bottom navigation
            Container(
              padding: EdgeInsets.all(16.sp),
              color: Colors.black,
              child: Row(
                children: [
                  // Previous button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: currentWorkoutIndex > 0 ? _previousWorkout : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Previous',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 16.w),
                  
                  // Next/Finish button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _nextWorkout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.c0000ff,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentWorkoutIndex == validWorkouts.length - 1 ? 'Finish' : 'Next Exercise',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            currentWorkoutIndex == validWorkouts.length - 1 
                                ? Icons.check 
                                : Icons.arrow_forward,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutPage(SuggestedWorkoutItem workout, int index) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout title and info
          Container(
            padding: EdgeInsets.all(20.sp),
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.c0000ff.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.displayTitle,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (workout.category != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.c0000ff.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.c0000ff,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          workout.category!.name ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.c0000ff,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    if (workout.gender != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.orange,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              workout.gender!.toLowerCase() == 'male' ? Icons.male : Icons.female,
                              size: 14.sp,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              workout.gender!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Video player
          if (workout.fullVideoUrl.isNotEmpty)
            Container(
              height: 250.h,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.c0000ff.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedVideoPlayerWidget(
                      url: workout.fullVideoUrl,
                    ),
                  ),
                  // Fullscreen button
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: GestureDetector(
                        onTap: _toggleFullScreen,
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Exercise instructions (placeholder for future implementation)
          Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise Instructions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Follow the video demonstration above to perform this exercise correctly. Pay attention to form and breathing.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[300],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _buildInfoItem(Icons.timer, 'Duration', '30-60 sec'),
                    SizedBox(width: 20.w),
                    _buildInfoItem(Icons.repeat, 'Sets', '3-4 sets'),
                    SizedBox(width: 20.w),
                    _buildInfoItem(Icons.local_fire_department, 'Difficulty', 'Medium'),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 100.h), // Extra space for bottom navigation
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.c0000ff,
          size: 20.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[400],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _previousWorkout() {
    if (currentWorkoutIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextWorkout() {
    if (currentWorkoutIndex < widget.workouts.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishWorkout();
    }
  }

  void _finishWorkout() {
    // Show completion dialog or navigate back
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Workout Complete! 🎉',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Great job completing all exercises for ${widget.day}!',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to workout plan
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: AppColors.c0000ff,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenVideo(SuggestedWorkoutItem workout) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Full-screen video player
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedVideoPlayerWidget(
                  url: workout.fullVideoUrl,
                ),
              ),
            ),

            // Top controls
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    // Exit fullscreen button
                    GestureDetector(
                      onTap: _exitFullScreen,
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.fullscreen_exit,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 16.w),
                    
                    // Workout info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.displayTitle,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${widget.day} • ${currentWorkoutIndex + 1}/${widget.workouts.length}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress bar
                    Container(
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: LinearProgressIndicator(
                        value: (currentWorkoutIndex + 1) / widget.workouts.length,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.c0000ff),
                      ),
                    ),

                    // Navigation controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Previous button
                        GestureDetector(
                          onTap: currentWorkoutIndex > 0 ? _previousWorkout : null,
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: currentWorkoutIndex > 0 
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.skip_previous,
                              color: currentWorkoutIndex > 0 ? Colors.white : Colors.grey,
                              size: 28.sp,
                            ),
                          ),
                        ),

                        // Exercise counter
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.c0000ff.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '${currentWorkoutIndex + 1} / ${widget.workouts.length}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Next button
                        GestureDetector(
                          onTap: _nextWorkout,
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              currentWorkoutIndex == widget.workouts.length - 1
                                  ? Icons.check
                                  : Icons.skip_next,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}