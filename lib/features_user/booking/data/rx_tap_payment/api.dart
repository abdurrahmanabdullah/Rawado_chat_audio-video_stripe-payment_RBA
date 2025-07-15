import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class TapPaymentApi {
  static final TapPaymentApi _singleton = TapPaymentApi._internal();
  TapPaymentApi._internal();
  static TapPaymentApi get instance => _singleton;

  Future<String> tapPayment({required Map body}) async {
    try {
      Response response = await postHttp(Endpoints.tapPayment(), body);

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseData = json.decode(json.encode(response.data));
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
