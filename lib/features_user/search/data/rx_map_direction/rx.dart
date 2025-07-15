import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetDirectionRX extends RxResponseInt<Map<String, dynamic>> {
  final api = GetDirectionApiApi.instance;

  GetDirectionRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<Map<String, dynamic>> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      Map<String, dynamic> data =
          await api.getDirection(destination: destination, origin: origin);
      // .waitingForFuture();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      // return
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      Map respose = data;
      log('ServiceResponse response: $respose');
      dataFetcher.sink.add(data);
      ToastUtil.showLongToast(respose.toString());
      return respose;
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
    message = exception.response!.statusMessage!;
    if (error.type == DioExceptionType.connectionError) {
      message = "Check Your Network Connection";
    }
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return false;
  }
}
