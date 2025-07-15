import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/service_schedule_time_response.dart';
import 'api.dart';

final class GetServiceScheduleRX extends RxResponseInt<ServiceScheduleTimeResponse> {
  final api = GetServiceScheduleApi.instance;

  bool success = false;

  GetServiceScheduleRX({required super.empty, required super.dataFetcher});

  ValueStream get getServiceScheduleData => dataFetcher.stream;

  String message = "";

  Future<void> schedule(int id, String date) async {
    try {
      ServiceScheduleTimeResponse data = await api.getSchedule(id, date);

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ServiceScheduleTimeResponse data) async {
    try {
      ServiceScheduleTimeResponse respose = data;
      log('Categories response: $respose');
      dataFetcher.sink.add(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    log('error.runtimeType${error.runtimeType}');
    DioException exception = error as DioException;
    // if(error is DioException)
    log(exception.message.toString());
    log(exception.response!.statusCode!.toString());
    message = exception.response!.data["message"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return message;
  }
}
