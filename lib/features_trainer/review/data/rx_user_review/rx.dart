import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/review/model/user_review_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetUserReviewRX extends RxResponseInt<UserReviewResponse> {
  final api = GetUserReviewApi.instance;

  GetUserReviewRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<UserReviewResponse> userReview(int page) async {
    try {
      UserReviewResponse data = await api.getUserReview(page);
      // .waitingForFuture();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      // return
      handleErrorWithReturn(error);
      rethrow;
    }
  }

  @override
  handleSuccessWithReturn(UserReviewResponse data) async {
    try {
      UserReviewResponse respose = data;
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
