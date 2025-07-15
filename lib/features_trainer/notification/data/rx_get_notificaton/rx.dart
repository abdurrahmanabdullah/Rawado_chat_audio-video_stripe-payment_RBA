import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetNotificationRx extends RxResponseInt {
  final api = GetNotificationApi.instance;

  GetNotificationRx({required super.empty, required super.dataFetcher});

  ValueStream get getNotification => dataFetcher.stream;

  Future<void> getNotificationData() async {
    try {
      Map data = await api.getNotificationData();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
