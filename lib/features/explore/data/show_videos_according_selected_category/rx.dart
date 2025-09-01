import 'dart:developer';
import 'package:fitsnap_ai/features/explore/data/show_videos_according_selected_category/api.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';

final class GetSelectedCategoryVideoRx extends RxResponseInt {
  final api = GetSelectedCategoryVideoApi.instance;

  GetSelectedCategoryVideoRx(
      {required super.empty, required super.dataFetcher});

  ValueStream get getSelectedCategoryVideoData => dataFetcher.stream;

  Future<void> fetchSelectedCategoryVideoResponse({int? categoryId}) async {
    try {
      Map data = await api.selectedCategoryVideoApi(categoryId: categoryId);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    log("Videos fetched successfully: $data");
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) {
    log("Error fetching videos: $error");
    dataFetcher.sink.addError(error);
  }
}
