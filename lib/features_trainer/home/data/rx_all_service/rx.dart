import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/all_service_model.dart';
import 'api.dart';

final class GetTrainerAllServicesRX extends RxResponseInt<AllServiceResponse> {
  final api = GetTrainerAllServiceApi.instance;

  bool success = false;

  GetTrainerAllServicesRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> getAllServices() async {
    try {
      AllServiceResponse data = await api.getAllServices();

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(AllServiceResponse data) async {
    try {
      AllServiceResponse respose = data;
      log('Profile details response: $respose');
      dataFetcher.sink.add(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    log('error.runtimeType${error.runtimeType}');
    DioException exception = error as DioException;
    if (error.type == DioExceptionType.connectionError) {
      message = "Check Your Network Connection";
    }
    log(exception.message.toString());
    log(exception.response!.statusCode!.toString());
    message = exception.response!.data["message"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return message;
  }
}
