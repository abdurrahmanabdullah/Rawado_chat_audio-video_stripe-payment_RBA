import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/features_user/massage/model/message_list_response.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetMessageListApi {
  static final GetMessageListApi _singleton = GetMessageListApi._internal();
  GetMessageListApi._internal();
  static GetMessageListApi get instance => _singleton;

  Future<MessageListResponse> getMessageList() async {
    try {
      Response response = await getHttp(Endpoints.messageList());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        MessageListResponse data =
            MessageListResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
