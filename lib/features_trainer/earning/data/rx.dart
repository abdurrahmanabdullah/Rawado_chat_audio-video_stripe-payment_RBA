import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetTrainerEarningRx extends RxResponseInt {
  final api = GetTrainerEarningApi.instance;

  GetTrainerEarningRx({required super.empty, required super.dataFetcher});

  ValueStream get getEarningStream => dataFetcher.stream;

  Future<void> getEarning(int id) async {
    try {
      Map data = await api.getEarning(id);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      Map respose = data;
      log('Profile details response: $respose');
      dataFetcher.sink.add(data);
    } catch (e) {
      rethrow;
    }
  }
}

