import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/stream_cleaner.dart';
import '/constants/app_constants.dart';
import '/helpers/di.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetLogOutRX extends RxResponseInt {
  final api = GetLogOutApi.instance;

  GetLogOutRX({required super.empty, required super.dataFetcher});

  ValueStream get getLogOutData => dataFetcher.stream;

  Future<void> fetchLogoutData() async {
    try {
      Map data = await api.fetchLogoutData().waitingForFuture();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  void handleSuccessWithReturn(data) {
    ToastUtil.showLongToast(data["message"].toString().split('.').first);
    appData.write(kKeyIsLoggedIn, false);
    // appData.erase();
    // NavigationService.navigateToUntilReplacement(Routes.logInScreen);
    totalDataClean();
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) {
    log('error $error');
    if (error is DioException) {
      log('statuscode ${error.response!.statusCode!}');
      // log('statuscode ${error.response!.data['code']}');
      if (error.response!.statusCode == 401) {
        ToastUtil.showLongToast(error.response!.statusMessage!);
        NavigationService.navigateToUntilReplacement(Routes.logInScreen);
        totalDataClean();
      }
    }
    dataFetcher.sink.addError(error);
    return false;
  }
}
