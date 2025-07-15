//azad added ...

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetProfileDetailsRX extends RxResponseInt<ProfileDetailsModel> {
  final api = GetProfileDetailsApi.instance;

  bool success = false;

  GetProfileDetailsRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> getprofileDetails() async {
    try {
      ProfileDetailsModel data = await api.getProfileDetails();

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ProfileDetailsModel data) async {
    try {
      ProfileDetailsModel respose = data;
      await appData.writeIfNull(kKeyUserName, data.data!.name);
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
    // if(error is DioException)
    log(exception.message.toString());
    log(exception.response!.statusCode!.toString());
    message = exception.response!.data["message"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return message;
  }
}
