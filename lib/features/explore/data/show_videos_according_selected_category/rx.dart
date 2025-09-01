import 'package:fitsnap_ai/features/explore/data/show_videos_according_selected_category/api.dart';
import 'package:rxdart/streams.dart';

import '../../../../networks/rx_base.dart';

final class GetSelectedCategoryVideoRx extends RxResponseInt {
  final api = GetSelectedCategoryVideoApi.instance;
  GetSelectedCategoryVideoRx(
      {required super.empty, required super.dataFetcher});

  ValueStream get getSelectedCategoryVideoData => dataFetcher.stream;

  Future<void> fetchSelectedCategoryVideoResponse() async {
    try {
      Map data = await api.selectedCategoryVideoApi();

      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
