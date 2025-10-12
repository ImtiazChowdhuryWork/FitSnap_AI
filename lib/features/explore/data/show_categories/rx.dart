import 'dart:developer';

import 'package:fitai/features/explore/data/show_categories/api.dart';
import 'package:fitai/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class GetExploreCategoriesRx extends RxResponseInt {
  final api = ExploreCategoriesApi.instance;

  GetExploreCategoriesRx({required super.empty, required super.dataFetcher});

  ValueStream get getExploreCategoriesData => dataFetcher.stream;

  Future<void> fetchExploreCategoriesResponse() async {
    try {
      Map data = await api.exploreCategories();

      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    log("Handle Success Log Data : $data");
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) {
    log("Handle Error Log data : $error");
  }
}
