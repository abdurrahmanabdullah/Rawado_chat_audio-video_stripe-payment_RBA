import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetNotificationApi {
  static final GetNotificationApi _singleton = GetNotificationApi._internal();
  GetNotificationApi._internal();
  static GetNotificationApi get instance => _singleton;
  Future<Map> getNotificationData() async {
    try {
      Response response = await getHttp(
        Endpoints.notification(),
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
      throw ErrorHandler.handle(error).failure;
    }
  }
}
