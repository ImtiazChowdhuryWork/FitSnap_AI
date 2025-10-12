import 'package:fitai/features/profile/data/api.dart';
import 'package:fitai/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetProfileInfoRx extends RxResponseInt {
  final api = GetProfileInfoApi.instance;
  GetProfileInfoRx({required super.empty, required super.dataFetcher});

  ValueStream get getProfileInfoData => dataFetcher.stream;

  Future<void> fetchProInfoData() async {
    try {
      Map data = await api.fetchProfileInfo();

      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
