import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetMessageRx extends RxResponseInt {
  final api = GetMessageApi.instance;

  GetMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get getMessage => dataFetcher.stream;

  Future<void> getMessageData(int id) async {
    try {
      Map data = await api.getMessageData(id);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
