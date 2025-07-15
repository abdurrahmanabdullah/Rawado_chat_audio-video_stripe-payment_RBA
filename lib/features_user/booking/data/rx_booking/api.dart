import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostBookingApi {
  static final PostBookingApi _singleton = PostBookingApi._internal();
  PostBookingApi._internal();
  static PostBookingApi get instance => _singleton;

  Future<Map> booking({required Map body, required int id}) async {
    try {
      Response response = await postHttp(Endpoints.booking(id), body);

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseData = json.decode(json.encode(response.data));
        return responseData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log('Error in serviceCreate: ${error.toString()}');
      rethrow;
    }
  }
}
