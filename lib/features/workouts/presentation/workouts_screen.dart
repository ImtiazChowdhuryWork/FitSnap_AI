import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/custom_drawer.dart';

import '../../../common_widgets/waiting_widget.dart';
import '../../../gen/colors.gen.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/navigation_provider.dart';

import '../../explore/presentation/widget/video_cache_manager.dart';

import '../models/suggested_workouts_model.dart';
import 'day_workout_details_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    getSuggestedWorkoutsRx.getSuggestedWorkouts();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.c0000ff,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      // Call API with date parameter
      getSuggestedWorkoutsRx.getSuggestedWorkouts(date: formattedDate);
    }
  }

  void _clearDateFilter() {
    setState(() {
      _selectedDate = null;
    });
    getSuggestedWorkoutsRx.getSuggestedWorkouts();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: AppColors.c0000ff,
        title: const Text("Suggested Workouts",
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _selectDate,
          ),
          if (_selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: _clearDateFilter,
            ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              getSuggestedWorkoutsRx.getSuggestedWorkouts();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.white),
            onPressed: () async {
              await VideoCacheManager.clearCache();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Video cache cleared")),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Filter Info
          if (_selectedDate != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.sp),
              margin: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColors.c0000ff.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.c0000ff.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: AppColors.c0000ff,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Filtered by: ${DateFormat('MMM dd, yyyy').format(_selectedDate!)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.c0000ff,
                    ),
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: StreamBuilder(
                stream: getSuggestedWorkoutsRx.getSuggestedWorkoutsData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: WaitingWidget());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    SuggestedWorkoutsModel suggestedWorkouts =
                        SuggestedWorkoutsModel.fromJson(snapshot.data);
                    final workoutDays = suggestedWorkouts.data ?? {};

                    if (workoutDays.isEmpty) {
                      return _buildErrorState();
                    }

                    log("Number of workout days: ${workoutDays.length}");

                    return _buildDayWiseWorkoutPlan(suggestedWorkouts);
                  } else {
                    return _buildErrorState();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayWiseWorkoutPlan(SuggestedWorkoutsModel suggestedWorkouts) {
    final sortedDays = suggestedWorkouts.sortedDays;
    
    return Column(
      children: [
        // Header with upload prompt for better workout plans
        Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.c0000ff.withOpacity(0.1),
                AppColors.c0000ff.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.c0000ff.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: AppColors.c0000ff.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColors.c0000ff,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get Optimized Workout Plan",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Upload your body image through AI Cam for personalized workouts",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.c0000ff,
                size: 16.sp,
              ),
            ],
          ),
        ),

        // Day cards
        Expanded(
          child: ListView.builder(
            itemCount: sortedDays.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final day = sortedDays[index];
              final dayWorkouts = suggestedWorkouts.data![day] ?? [];
              final firstWorkout = dayWorkouts.isNotEmpty ? dayWorkouts.first.workout : null;
              
              return Container(
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day header with image
                    Container(
                      height: 180.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.c0000ff.withOpacity(0.8),
                            AppColors.c0000ff.withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Background pattern or image placeholder
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop'),
                                fit: BoxFit.cover,
                                opacity: 0.3,
                              ),
                            ),
                          ),
                          // Overlay content
                          Container(
                            padding: EdgeInsets.all(20.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20.r),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        day,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Text(
                                        '${dayWorkouts.length} exercises',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                if (firstWorkout != null) ...[
                                  Text(
                                    firstWorkout.displayTitle,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  if (firstWorkout.category != null)
                                    Text(
                                      firstWorkout.category!.name ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content section
                    Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Workout list preview
                          Text(
                            "Today's Workout Plan",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          
                          // Show first 3 workouts as preview
                          ...dayWorkouts.take(3).map((dayWorkout) {
                            final workout = dayWorkout.workout;
                            if (workout == null) return const SizedBox.shrink();
                            
                            return Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.c0000ff,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      workout.displayTitle,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (workout.category != null)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.c0000ff.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6.r),
                                      ),
                                      child: Text(
                                        workout.category!.name ?? '',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.c0000ff,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                          
                          if (dayWorkouts.length > 3)
                            Padding(
                              padding: EdgeInsets.only(left: 18.w, top: 4.h),
                              child: Text(
                                "+${dayWorkouts.length - 3} more exercises",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),

                          SizedBox(height: 20.h),

                          // Get Started Button
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to workout details or start workout
                                _startDayWorkout(day, dayWorkouts);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.c0000ff,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
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
              );
            },
          ),
        ),
      ],
    );
  }

  void _startDayWorkout(String day, List<WorkoutDayItem> workouts) {
    log("Starting workout for $day with ${workouts.length} exercises");
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayWorkoutDetailsScreen(
          day: day,
          workouts: workouts,
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    // Check if we have a selected date and it's not today
    bool isDateFiltered = _selectedDate != null;
    bool isNotToday = _selectedDate != null && 
        !_isSameDay(_selectedDate!, DateTime.now());
    
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.c0000ff.withOpacity(0.1),
              AppColors.c0000ff.withOpacity(0.05),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.c0000ff.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.c0000ff.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                color: AppColors.c0000ff.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDateFiltered && isNotToday 
                    ? Icons.calendar_today_outlined 
                    : Icons.camera_alt_rounded,
                size: 48.sp,
                color: AppColors.c0000ff,
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              isDateFiltered && isNotToday 
                  ? "No Workouts Available"
                  : "Get Personalized Workouts",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Message
            Text(
              isDateFiltered && isNotToday
                  ? "No workout recommendations were generated for ${DateFormat('MMM dd, yyyy').format(_selectedDate!)}. Workouts are typically suggested after body image analysis."
                  : "You need to take your body image using AI cam to get personalized workout recommendations",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),

            // Button - only show if it's today or no date filter
            if (!isDateFiltered || !isNotToday)
              Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.c0000ff, Color(0xFF2563EB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.c0000ff.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to AI cam screen using navigation provider
                    final navigationProvider =
                        Provider.of<NavigationProvider>(context,
                            listen: false);
                    navigationProvider
                        .setIndex(2); // AI cam is at index 2
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Take Body Image",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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
