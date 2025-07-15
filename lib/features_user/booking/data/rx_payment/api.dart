import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostPaymentIntentApi {
  static final PostPaymentIntentApi _singleton = PostPaymentIntentApi._internal();
  PostPaymentIntentApi._internal();
  static PostPaymentIntentApi get instance => _singleton;

  Future<Map> paymentIntent({required Map body}) async {
    try {
      Response response = await postHttp(Endpoints.paymentIntent(), body);

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
