import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../features_trainer/home/model/all_service_model.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetCustomerAllServiceApi {
  static final GetCustomerAllServiceApi _singleton = GetCustomerAllServiceApi._internal();
  GetCustomerAllServiceApi._internal();
  static GetCustomerAllServiceApi get instance => _singleton;

  Future<AllServiceResponse> getAllServices() async {
    try {
      Response response = await getHttp(Endpoints.customerAllService());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        AllServiceResponse data =
            AllServiceResponse.fromRawJson(json.encode(response.data));
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
