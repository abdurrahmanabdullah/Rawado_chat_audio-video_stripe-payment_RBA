import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/service/model/categories_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetCategoriesRX extends RxResponseInt<CategoriesResponse> {
  final api = GetCategoriesApi.instance;

  bool success = false;

  GetCategoriesRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> getCategories(
  ) async {
    try {
      CategoriesResponse data = await api
          .getCategories(
          );

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(CategoriesResponse data) async {
    try {
      CategoriesResponse respose = data;
      log('Categories response: $respose');
      dataFetcher.sink.add(data);
      // if (respose.code == 200) {
      //   // if (respose.status == true) {
      //   //   // NavigationService.navigateToReplacement(Routes.loading);
      //   // } else {
      //   //   await appData.write(kKeyIsLoggedIn, false);
      //   // }
      // }
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
