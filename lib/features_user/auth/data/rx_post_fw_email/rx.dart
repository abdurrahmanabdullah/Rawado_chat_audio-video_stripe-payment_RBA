import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostForgetEmailRX extends RxResponseInt {
  final api = PostForgetEmailApi.instance;

  String message = "Something went wrong";

  PostForgetEmailRX({required super.empty, required super.dataFetcher});

  ValueStream get getPostForgetEmailRes => dataFetcher.stream;

  Future<bool> postForgetEmail({String? email}) async {
    try {
      Map<String, dynamic> data = {"email": email};
      Map resdata = await api.postForgetEmail(data);
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);

    // message = data["message"];
    // if (data["success"] == false) throw Exception();
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      int code = error.response?.data["code"] ?? -1;
      log("Error: $message, Code: $code");
      if (code == -1) {
        message = "Something went wrong";
      }
      if (code == 422) {
        message = "The selected email is invalid";

        //hey, chatGPT here i want to access the provider email
      }
    }

    return super.handleErrorWithReturn(message);
  }
}
