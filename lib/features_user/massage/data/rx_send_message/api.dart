import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostSendMessageApi {
  static final PostSendMessageApi _singleton = PostSendMessageApi._internal();
  PostSendMessageApi._internal();
  static PostSendMessageApi get instance => _singleton;
  Future<Map> postSendMessage(Map data, int id) async {
    try {
      Response response = await postHttp(
        Endpoints.sendMessage(id),
        data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
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
