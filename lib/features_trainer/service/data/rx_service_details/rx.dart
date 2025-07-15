import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/service/model/service_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetServiceDetailsRX extends RxResponseInt<CreateServiceResponse> {
  final api = GetServicDetailsApi.instance;

  bool success = false;

  GetServiceDetailsRX({required super.empty, required super.dataFetcher});

  ValueStream get getServiceDetaisData => dataFetcher.stream;

  String message = "";

  Future<void> getServiceDetails(int id) async {
    try {
      CreateServiceResponse data = await api.getServiceDetails(id);

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(CreateServiceResponse data) async {
    try {
      CreateServiceResponse respose = data;
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
