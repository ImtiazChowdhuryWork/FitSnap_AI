import 'package:fitsnap_ai/features/privacy_policy/data/api.dart';
import 'package:fitsnap_ai/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class GetPrivacyPolicyRx extends RxResponseInt {
  final api = GetPrivacyPolicyApi.instance;
  GetPrivacyPolicyRx({required super.empty, required super.dataFetcher});

  ValueStream get getPrivacyPolicyData => dataFetcher.stream;

  Future<void> fetchPrivacyPolicyData() async {
    try {
      Map data = await api.fetchPrivacyPolicyApi();

      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
