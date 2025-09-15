import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../gen/colors.gen.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/navigation_provider.dart';
import '../../explore/presentation/widget/catched_video_player.dart';
import '../../explore/presentation/widget/video_cache_manager.dart';
import '../models/suggested_workouts_model.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  void initState() {
    super.initState();
    getSuggestedWorkoutsRx.getSuggestedWorkouts();
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
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: StreamBuilder(
          stream: getSuggestedWorkoutsRx.getSuggestedWorkoutsData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: WaitingWidget());
            } else if (snapshot.hasData && snapshot.data != null) {
              SuggestedWorkoutsModel suggestedWorkouts =
                  SuggestedWorkoutsModel.fromJson(snapshot.data);
              final workoutsList = suggestedWorkouts.data ?? [];

              if (workoutsList.isEmpty) {
                return Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
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
                            Icons.camera_alt_rounded,
                            size: 48.sp,
                            color: AppColors.c0000ff,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Title
                        Text(
                          "Get Personalized Workouts",
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
                          "You need to take your body image using AI cam to get personalized workout recommendations",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32.h),

                        // Button
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

              log("Number of suggested workouts: ${workoutsList.length}");

              return ListView.builder(
                itemCount: workoutsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final workout = workoutsList[index];
                  final videoUrl = workout.fullVideoUrl;
                  final workoutTitle = workout.displayTitle;

                  log("Workout Url : $videoUrl");

                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Workout Title
                        Text(
                          workoutTitle,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        // Gender and Category Info
                        if (workout.gender != null || workout.category != null)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                            child: Row(
                              children: [
                                if (workout.gender != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: Colors.blue.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      workout.displayGender,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ),
                                if (workout.gender != null &&
                                    workout.category != null)
                                  SizedBox(width: 8.w),
                                if (workout.category != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: Colors.green.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      workout.category?.name ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                        // Video Player
                        CachedVideoPlayerWidget(
                          key: ValueKey(videoUrl),
                          url: videoUrl,
                        ),
                        SizedBox(height: 8.h),
                        const Divider(),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: NotFoundWidget());
            }
          },
        ),
      ),
    );
  }
}
