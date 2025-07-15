// ignore_for_file: non_constant_identifier_names

import 'package:rxdart/rxdart.dart';

import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostForgertPwRX extends RxResponseInt {
  final api = PostForgetPwApi.instance;

  String message = "Something went wrong";

  PostForgertPwRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postProductBasicData(String email, String password,
      String password_confirmation, String code) async {
    try {
      Map allData =
          await api.postForgetPw(email, password, password_confirmation, code);
      return handleSuccessWithReturn(allData);
    } catch (error) {
      return handleSuccessWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
    message = data["message"];
    if (data["status"] == false) {
      ToastUtil.showShortToast(message);
    } else if (data["status"] == true) {
      return true;
    } else {
      throw Exception();
    }
  }
}
