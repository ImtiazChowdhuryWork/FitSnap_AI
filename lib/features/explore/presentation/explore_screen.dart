// import 'dart:developer';

// import 'package:fitsnap_ai/common_widgets/custom_text_form_field.dart';
// import 'package:fitsnap_ai/common_widgets/not_found_widget.dart';
// import 'package:fitsnap_ai/common_widgets/waiting_widget.dart';
// import 'package:fitsnap_ai/constants/text_font_style.dart';
// import 'package:fitsnap_ai/features/explore/presentation/widget/explore_category_card.dart';
// import 'package:fitsnap_ai/gen/colors.gen.dart';
// import 'package:fitsnap_ai/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// import '../../../networks/api_acess.dart';
// import '../../../provider/explore_workout_categories.dart';
// import '../model/explore_category_model/explore_categories_model.dart';
// import '../model/show_selected_category_video_model/show_selected_category_video_model.dart';
// import 'widget/video_showing_widget.dart';

// class ExploreScreen extends StatefulWidget {
//   const ExploreScreen({super.key});

//   @override
//   State<ExploreScreen> createState() => _ExploreScreenState();
// }

// class _ExploreScreenState extends State<ExploreScreen> {
//   @override
//   void initState() {
//     super.initState();
//     getExploreCategoriesRx.fetchExploreCategoriesResponse();
//     getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ExploreWorkoutCategoriesProvider>(
//         builder: (context, controller, index) {
//       return Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// Section : Search Bar
//                   CustomFormField(
//                     hintText: "Search here",
//                     borderColor: AppColors.c0B61D4,
//                     suffixIcon: Icon(
//                       Icons.search_outlined,
//                       color: AppColors.c0B61D4,
//                     ),
//                   ),
//                   UIHelper.verticalSpace(20.h),

//                   /// Section : Workout Categories Text
//                   Text(
//                     "Workout Categories",
//                     style: TextFontStyle.headline20w500c000000StyleInter,
//                   ),
//                   UIHelper.verticalSpace(20.h),

//                   /// Section : Workout Categories
// SizedBox(
//   width: 1.sw,
//   height: 40.h,
//   child: StreamBuilder(
//     stream: getExploreCategoriesRx.getExploreCategoriesData,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState ==
//           ConnectionState.waiting) {
//         return const WaitingWidget();
//       } else if (snapshot.hasData && snapshot.data != null) {
//         ExploreCategoriesModel exploreCategories =
//             ExploreCategoriesModel.fromJson(snapshot.data);
//         var data = exploreCategories.data;

//         return ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemCount: data!.length,
//           separatorBuilder: (_, __) => SizedBox(width: 12.w),
//           itemBuilder: (context, index) {
//             log("Category Names : ${data[index].name!}");
//             return ExploreCategoryCard(
//               onTap: () {
//                 controller.updateSelectedCategory(
//                     id: data[index].id!);
//               },
//               isSelected: controller
//                   .isCategorySelected(data[index].id!),
//               categoryName: data[index].name! ?? '',
//             );
//           },
//         );
//       } else {
//         return const NotFoundWidget();
//       }
//     },
//   ),
// ),
//                   UIHelper.verticalSpace(20.h),

//                   StreamBuilder(
//                     stream: (getSelectedCategoryVideoRx
//                         .getSelectedCategoryVideoData),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const WaitingWidget();
//                       } else if (snapshot.hasData && snapshot.data != null) {
//                         ShowSelectedCategoryVideoModel
//                             showSelectedCategoryVideo =
//                             ShowSelectedCategoryVideoModel.fromJson(
//                                 snapshot.data);

//                         var data = showSelectedCategoryVideo.data;
//                         return ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: data!.length,
//                           separatorBuilder: (context, index) =>
//                               UIHelper.verticalSpace(10.h),
//                           itemBuilder: (context, index) {
//                             var videoItem = data[index];

//                             UIHelper.verticalSpace(10.h);
//                             log("Video title : ${videoItem.title}");
//                             log("Video Link : ${videoItem.video}");
//                             log("Uer Gender  : ${videoItem.gender}");
//                             log("Video ID : ${videoItem.id}");
//                             log("Video Category ID : ${videoItem.category}");

//                             UIHelper.verticalSpace(10.h);

//                             return VideoShowingWidget(
//                               videoTitle: videoItem.title!,
//                               videoLink: videoItem.video!,
//                               videoCategoryId: videoItem.category!.toString(),
//                               videoId: videoItem.id.toString(),
//                               userGender: videoItem.gender!.toString(),
//                             );
//                           },
//                         );
//                       } else {
//                         return const NotFoundWidget();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../../common_widgets/not_found_widget.dart';
// import '../../../common_widgets/waiting_widget.dart';
// import '../../../networks/api_acess.dart';
// import '../../../provider/explore_workout_categories.dart';
// import '../data/show_videos_according_selected_category/rx.dart';
// import '../model/explore_category_model/explore_categories_model.dart';
// import '../model/show_selected_category_video_model/show_selected_category_video_model.dart';
// import '../presentation/widget/explore_category_card.dart';
// import '../presentation/widget/video_showing_widget.dart';

// class ExploreScreen extends StatefulWidget {
//   const ExploreScreen({super.key});

//   @override
//   State<ExploreScreen> createState() => _ExploreScreenState();
// }

// class _ExploreScreenState extends State<ExploreScreen> {
//   late GetSelectedCategoryVideoRx getSelectedCategoryVideoRx;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize Rx for videos
//     getSelectedCategoryVideoRx =
//         GetSelectedCategoryVideoRx(empty: [], dataFetcher: BehaviorSubject());
//     // Fetch all videos by default
//     getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse();
//   }

//   // Call this when a category is selected
//   void onCategorySelected(int categoryId) {
//     getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse(
//         categoryId: categoryId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ExploreWorkoutCategoriesProvider>(
//       builder: (context, controller, _) {
//         return Scaffold(
//           appBar: AppBar(title: const Text("Explore Workouts")),
//           body: Padding(
//             padding: EdgeInsets.all(16.sp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Workout Categories Horizontal List
//                 SizedBox(
//                   width: 1.sw,
//                   height: 40.h,
//                   child: StreamBuilder(
//                     stream: getExploreCategoriesRx.getExploreCategoriesData,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const WaitingWidget();
//                       } else if (snapshot.hasData && snapshot.data != null) {
//                         ExploreCategoriesModel exploreCategories =
//                             ExploreCategoriesModel.fromJson(
//                                 snapshot.data as Map<String, dynamic>);
//                         var data = exploreCategories.data;

//                         return ListView.separated(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: data!.length,
//                           separatorBuilder: (_, __) => SizedBox(width: 12.w),
//                           itemBuilder: (context, index) {
//                             final category = data[index];
//                             log("Category: ${category.name}");
//                             return ExploreCategoryCard(
//                               onTap: () {
//                                 controller.updateSelectedCategory(
//                                     id: category.id!);
//                                 onCategorySelected(category.id!);
//                               },
//                               isSelected:
//                                   controller.isCategorySelected(category.id!),
//                               categoryName: category.name ?? '',
//                             );
//                           },
//                         );
//                       } else {
//                         return const NotFoundWidget();
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 // Videos List
//                 Expanded(
//                   child: StreamBuilder(
//                     stream:
//                         getSelectedCategoryVideoRx.getSelectedCategoryVideoData,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (!snapshot.hasData) {
//                         return const Center(child: Text("No videos found"));
//                       } else {
//                         // Convert Map -> Model
//                         final ShowSelectedCategoryVideoModel showVideos =
//                             ShowSelectedCategoryVideoModel.fromJson(
//                                 snapshot.data as Map<String, dynamic>);

//                         if (showVideos.data == null ||
//                             showVideos.data!.isEmpty) {
//                           return const Center(child: Text("No videos found"));
//                         }

//                         return ListView.separated(
//                           itemCount: showVideos.data!.length,
//                           separatorBuilder: (_, __) => SizedBox(height: 10.h),
//                           itemBuilder: (context, index) {
//                             final video = showVideos.data![index];
//                             log("Video title: ${video.title}");
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(video.title ?? '',
//                                     style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 8.h),
//                                 VideoPlayerWidget(
//                                     url:
//                                         "https://focus-lab-ai-fitness-app-1.onrender.com/api${video.video}" ??
//                                             ''),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/explore_workout_categories.dart';
import '../data/show_videos_according_selected_category/rx.dart';
import '../model/explore_category_model/explore_categories_model.dart';
import '../model/show_selected_category_video_model/show_selected_category_video_model.dart';
import '../presentation/widget/explore_category_card.dart';
import '../presentation/widget/video_showing_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late GetSelectedCategoryVideoRx getSelectedCategoryVideoRx;

  @override
  void initState() {
    super.initState();

    // Initialize Rx for videos
    getSelectedCategoryVideoRx =
        GetSelectedCategoryVideoRx(empty: [], dataFetcher: BehaviorSubject());

    // Fetch all videos by default
    getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse();
  }

  // Call this when a category is selected
  void onCategorySelected(int categoryId) {
    getSelectedCategoryVideoRx.fetchSelectedCategoryVideoResponse(
        categoryId: categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreWorkoutCategoriesProvider>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(title: const Text("Explore Workouts")),
          body: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Workout Categories Horizontal List
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
                            ExploreCategoriesModel.fromJson(
                                snapshot.data as Map<String, dynamic>);
                        final data = exploreCategories.data;

                        if (data == null || data.isEmpty) {
                          return const NotFoundWidget();
                        }

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          separatorBuilder: (_, __) => SizedBox(width: 12.w),
                          itemBuilder: (context, index) {
                            final category = data[index];
                            log("Category: ${category.name}");

                            return ExploreCategoryCard(
                              onTap: () {
                                controller.updateSelectedCategory(
                                    id: category.id!);
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
                  child: StreamBuilder(
                    stream:
                        getSelectedCategoryVideoRx.getSelectedCategoryVideoData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text("No videos found"));
                      } else {
                        final ShowSelectedCategoryVideoModel showVideos =
                            ShowSelectedCategoryVideoModel.fromJson(
                                snapshot.data as Map<String, dynamic>);

                        if (showVideos.data == null ||
                            showVideos.data!.isEmpty) {
                          return const Center(child: Text("No videos found"));
                        }

                        return ListView.separated(
                          itemCount: showVideos.data!.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final video = showVideos.data![index];

                            // Construct full URL and encode spaces
                            final videoUrl =
                                "https://focus-lab-ai-fitness-app-1.onrender.com${video.video}";
                            final encodedUrl = Uri.encodeFull(videoUrl);

                            log("Video title: ${video.title}");
                            log("Video URL: $encodedUrl");

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(video.title ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.h),
                                VideoPlayerWidget(url: encodedUrl),
                              ],
                            );
                          },
                        );
                      }
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
