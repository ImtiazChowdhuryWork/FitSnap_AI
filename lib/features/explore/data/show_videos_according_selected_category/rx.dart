// import 'dart:developer';
// import 'package:fitai/features/explore/data/show_videos_according_selected_category/api.dart';
// import 'package:rxdart/rxdart.dart';

// import '../../../../networks/rx_base.dart';

// final class GetSelectedCategoryVideoRx extends RxResponseInt {
//   final api = GetSelectedCategoryVideoApi.instance;

//   GetSelectedCategoryVideoRx(
//       {required super.empty, required super.dataFetcher});

//   ValueStream get getSelectedCategoryVideoData => dataFetcher.stream;

//   Future<void> fetchSelectedCategoryVideoResponse({int? categoryId}) async {
//     try {
//       Map data = await api.selectedCategoryVideoApi(categoryId: categoryId);
//       handleSuccessWithReturn(data);
//     } catch (error) {
//       handleErrorWithReturn(error);
//     }
//   }

//   @override
//   handleSuccessWithReturn(data) {
//     log("Videos fetched successfully: $data");
//     dataFetcher.sink.add(data);
//   }

//   @override
//   handleErrorWithReturn(error) {
//     log("Error fetching videos: $error");
//     dataFetcher.sink.addError(error);
//   }
// }

import 'dart:developer';

import 'package:fitai/features/explore/data/show_videos_according_selected_category/api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import '../../model/show_selected_category_video_model/show_selected_category_video_model.dart';

final class GetSelectedCategoryVideoRx extends RxResponseInt {
  final api = GetSelectedCategoryVideoApi.instance;

  GetSelectedCategoryVideoRx(
      {required super.empty, required super.dataFetcher});

  // Cast the stream to the correct type
  ValueStream<ShowSelectedCategoryVideoModel?>
      get getSelectedCategoryVideoData =>
          dataFetcher.stream as ValueStream<ShowSelectedCategoryVideoModel?>;

  Future<void> fetchSelectedCategoryVideoResponse({int? categoryId}) async {
    try {
      Map<dynamic, dynamic> data =
          await api.selectedCategoryVideoApi(categoryId: categoryId);
      // Convert Map<dynamic, dynamic> to Map<String, dynamic>
      final Map<String, dynamic> stringKeyedData =
          data.map((key, value) => MapEntry(key.toString(), value));

      // Convert Map to model
      final videoModel =
          ShowSelectedCategoryVideoModel.fromJson(stringKeyedData);
      handleSuccessWithReturn(videoModel);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    log("Videos fetched successfully: $data");
    // Cast the data to the expected type before adding to sink
    if (data is ShowSelectedCategoryVideoModel) {
      log("✅ API success: ${data.success}");
      log("📩 Message: ${data.message}");
      log("🎥 Total videos fetched: ${data.data!.length}");

      // Log the first few videos
      for (var workout in data.data!.take(data.data!.length)) {
        log("Workout ID : ${workout.id} ");
        log("Workout Title : ${workout.title}");
        log("User Gendeer : ${workout.gender}");
        log("Workout Category : ${workout.category}");
        log("Video URL: ${workout.video}");
      }
      (dataFetcher as BehaviorSubject<ShowSelectedCategoryVideoModel?>)
          .sink
          .add(data);
    }
  }

  @override
  handleErrorWithReturn(error) {
    log("Error fetching videos: $error");
    dataFetcher.sink.addError(error);
  }
}
