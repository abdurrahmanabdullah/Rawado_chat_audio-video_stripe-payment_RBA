import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostUpdateProfileApi {
  static final PostUpdateProfileApi _singleton =
      PostUpdateProfileApi._internal();
  PostUpdateProfileApi._internal();
  static PostUpdateProfileApi get instance => _singleton;

  Future<Map> updateProfile({required Map<String, dynamic> body}) async {
    try {
      Response response = await postHttp(Endpoints.updateProfile(), FormData.fromMap(body));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
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
