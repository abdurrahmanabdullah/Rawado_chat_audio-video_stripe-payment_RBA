import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetMessageRoomRx extends RxResponseInt<Map> {
  final api = GetMessageRoomCreateApi.instance;

  GetMessageRoomRx({required super.empty, required super.dataFetcher});

  ValueStream get getMessageRoomData => dataFetcher.stream;

  Future<Map> getMessageRoom(int id) async {
    try {
      Map data = await api.getMessageRoom(id);
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      rethrow;
    }
  }
}
