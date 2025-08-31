import 'package:fitsnap_ai/features/explore/data/api.dart';
import 'package:fitsnap_ai/networks/rx_base.dart';
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
}
