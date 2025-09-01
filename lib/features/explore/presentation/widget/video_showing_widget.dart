import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoShowingWidget extends StatelessWidget {
  final String videoTitle;
  final String videoLink;
  final String userGender;
  final String videoId;
  final String videoCategoryId;
  const VideoShowingWidget({
    super.key,
    required this.videoTitle,
    required this.videoLink,
    required this.userGender,
    required this.videoId,
    required this.videoCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Section : Video Title
            Text("Video Title : $videoTitle"),
            UIHelper.verticalSpace(5.h),

            ///Section : Video Link
            Text("Video Link : $videoLink"),
            UIHelper.verticalSpace(5.h),

            ///Section : Gender
            Text("User Gender : $userGender"),
            UIHelper.verticalSpace(5.h),

            ///Section : Video Id
            Text("Video ID : $videoId"),
            UIHelper.verticalSpace(5.h),

            ///Section : Video Category Id
            Text("Video Category ID : $videoCategoryId"),
            UIHelper.verticalSpace(5.h),
          ],
        ),
      ),
    );
  }
}
