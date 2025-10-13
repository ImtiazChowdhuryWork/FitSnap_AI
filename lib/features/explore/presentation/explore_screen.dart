///working version : v.0.0.1
library;

import 'dart:developer';
import 'package:fitai/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../gen/colors.gen.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/explore_workout_categories.dart';
import '../model/explore_category_model/explore_categories_model.dart';
import '../model/show_selected_category_video_model/show_selected_category_video_model.dart';
import '../presentation/widget/explore_category_card.dart';
import 'widget/catched_video_player.dart';
import 'widget/video_cache_manager.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    getExploreCategoriesRx.fetchExploreCategoriesResponse();
    getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse();
  }

  void onCategorySelected(int categoryId) {
    getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse(
      categoryId: categoryId == -1 ? null : categoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreWorkoutCategoriesProvider>(
      builder: (context, controller, _) {
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
            title: const Text("Explore Workouts Screen"),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_forever),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories Horizontal List
                SizedBox(
                  width: 1.sw,
                  height: 40.h,
                  child: StreamBuilder(
                    stream: getExploreCategoriesRx.getExploreCategoriesData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const WaitingWidget();
                      } else if (snapshot.hasData && snapshot.data != null) {
                        ExploreCategoriesModel exploreCategories =
                            ExploreCategoriesModel.fromJson(snapshot.data);
                        final data = exploreCategories.data ?? [];

                        if (data.isEmpty) return const NotFoundWidget();

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length + 1,
                          separatorBuilder: (_, __) => SizedBox(width: 12.w),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return ExploreCategoryCard(
                                onTap: () {
                                  controller.updateSelectedCategory(id: -1);
                                  onCategorySelected(-1);
                                },
                                isSelected: controller.isCategorySelected(-1),
                                categoryName: "All",
                              );
                            }

                            final category = data[index - 1];
                            return ExploreCategoryCard(
                              onTap: () {
                                controller.updateSelectedCategory(
                                  id: category.id!,
                                );
                                onCategorySelected(category.id!);
                              },
                              isSelected:
                                  controller.isCategorySelected(category.id!),
                              categoryName: category.name ?? '',
                            );
                          },
                        );
                      } else {
                        return const NotFoundWidget();
                      }
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                // Videos List
                Expanded(
                  child: Consumer<ExploreWorkoutCategoriesProvider>(
                    builder: (context, categoryController, _) {
                      return StreamBuilder<ShowSelectedCategoryVideoModel?>(
                        stream: getSelectedCategoryVideoRx
                            .getSelectedCategoryVideoData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: WaitingWidget());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          }

                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Center(
                                child: Text("No workout data available"));
                          }

                          final videoModel = snapshot.data!;
                          if (videoModel.success == false) {
                            return Center(
                                child: Text(
                                    "API Error: ${videoModel.message ?? 'Unknown error'}"));
                          }

                          if (videoModel.data == null ||
                              videoModel.data!.isEmpty) {
                            return const Center(
                                child: Text("No workouts found"));
                          }

                          final videosList = videoModel.data!;
                          log("Number of videos: ${videosList.length}");

                          return ListView.builder(
                            key:
                                ValueKey(categoryController.selectedCategoryId),
                            itemCount: videosList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final video = videosList[index];
                              // Fix URL construction - video.video should contain the full path or relative path
                              String videoUrl;
                              if (video.video != null &&
                                  video.video!.startsWith('http')) {
                                // If video.video already contains a full URL, use it as is
                                videoUrl = video.video!;
                              } else {
                                // If it's a relative path, construct the full URL
                                videoUrl =
                                    "$baseUrl${video.video ?? ""}";
                              }
                              final videoTitle =
                                  video.title ?? "Untitled Video";

                              log("Video Url : $videoUrl");

                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      videoTitle,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
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
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
