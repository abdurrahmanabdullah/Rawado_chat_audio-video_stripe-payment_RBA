import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetMessageRoomCreateApi {
  static final GetMessageRoomCreateApi _singleton =
      GetMessageRoomCreateApi._internal();
  GetMessageRoomCreateApi._internal();
  static GetMessageRoomCreateApi get instance => _singleton;
  Future<Map> getMessageRoom(int id) async {
    try {
      Response response = await getHttp(
        Endpoints.messageRoom(id),
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
     // ErrorHandler.handle(error).failure.responseMessage;
    }
  }
}
