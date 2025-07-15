import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';
import '../../model/trainer_rating_response.dart';
import 'api.dart';

final class GetTrainerRatingRX extends RxResponseInt<TrainerRatingResponse> {
  final api = GetTrainerRatingApi.instance;

  GetTrainerRatingRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> trainerRating() async {
    try {
      TrainerRatingResponse data = await api.trainerRating();
      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      // return
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(TrainerRatingResponse data) async {
    try {
      TrainerRatingResponse respose = data;
      log('ServiceResponse response: $respose');
      dataFetcher.sink.add(data);
      // ToastUtil.showLongToast(respose.message!);
      return data;
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
    // ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return false;
  }
}
