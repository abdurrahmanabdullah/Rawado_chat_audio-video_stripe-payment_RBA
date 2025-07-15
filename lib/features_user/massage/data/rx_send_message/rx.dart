import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostSendMessageRx extends RxResponseInt {
  final api = PostSendMessageApi.instance;

  String message = "Something went wrong";

  PostSendMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get postSendMessage => dataFetcher.stream;

  Future<bool> postMessage({int? id, String? content}) async {
    try {
      Map<String, dynamic> data = {
        // "chat_room_id": chatRoomId,
        'message': content,
      };
      Map resdata = await api.postSendMessage(data, id!);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);

    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";

      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    ToastUtil.showLongToast(message);
    // CustomToastMessage('Error', message);
    return false;
  }
}
