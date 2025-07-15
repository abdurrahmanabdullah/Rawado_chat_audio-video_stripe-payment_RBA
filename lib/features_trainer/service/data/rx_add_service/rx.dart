import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/service_response.dart';
import 'api.dart';

final class PostServiceCreateRX extends RxResponseInt<CreateServiceResponse> {
  final api = PostServiceCreteApi.instance;

  PostServiceCreateRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> serviceCreate(
   String name, String email, int categoryId,String charge,String lat, String lon,String desc, String locaation, List<File> imagePaths,
  ) async {
    try {
      CreateServiceResponse data = await api
          .serviceCreate( name : name, email: email, categoryId: categoryId, charge: charge, lat: lat ,lon: lon, desc: desc, locaation: locaation, imagePaths: imagePaths
          );
          // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      // return 
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(CreateServiceResponse data) async {
    try {
      CreateServiceResponse respose = data;
      log('ServiceResponse response: $respose');
      dataFetcher.sink.add(data);
      // if (respose.code == 200) {
      //   if (respose.status == true) {
      //     // NavigationService.navigateToReplacement(Routes.loading);
      //   } else {
      //     await appData.write(kKeyIsLoggedIn, false);
       ToastUtil.showLongToast(respose.message!);
       return data;
      //   }
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
    return false;
  }
}
