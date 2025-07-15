import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostAddTokenApi {
  static final PostAddTokenApi _singleton = PostAddTokenApi._internal();
  PostAddTokenApi._internal();
  static PostAddTokenApi get instance => _singleton;
  Future<Map> addToken(Map data) async {
    try {
      Response response = await postHttp(
        Endpoints.addToken(),
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
