//azad added ...
import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/message_list_response.dart';
import 'api.dart';

final class GetMessageListRX extends RxResponseInt<MessageListResponse> {
  final api = GetMessageListApi.instance;

  bool success = false;

  GetMessageListRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> getMessageList() async {
    try {
      MessageListResponse data = await api.getMessageList();

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(MessageListResponse data) async {
    try {
      MessageListResponse respose = data;
      log('Profile details response: $respose');
      dataFetcher.sink.add(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      int code = error.response?.data["code"] ?? -1;
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
      log("Error: $message, Code: $code");
    }
    ToastUtil.showLongToast(message);

    //return super.handleErrorWithReturn(message);
  }
}
