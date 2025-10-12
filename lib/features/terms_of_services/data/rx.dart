import 'package:fitai/features/terms_of_services/data/api.dart';
import 'package:rxdart/rxdart.dart';

import '../../../networks/rx_base.dart';

final class GetTermsOfServicesRx extends RxResponseInt {
  final api = GetTermsOfServicesApi.instance;

  GetTermsOfServicesRx({required super.empty, required super.dataFetcher});

  ValueStream get getTermsOfServiceData => dataFetcher.stream;

  Future<void> fetchTermsOfServicesData() async {
    try {
      Map data = await api.fetchTermsOfServicesApi();

      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
