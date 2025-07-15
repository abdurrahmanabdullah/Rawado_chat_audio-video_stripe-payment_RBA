import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/all_service_model.dart';

final class GetTrainerAllServiceApi {
  static final GetTrainerAllServiceApi _singleton = GetTrainerAllServiceApi._internal();
  GetTrainerAllServiceApi._internal();
  static GetTrainerAllServiceApi get instance => _singleton;

  Future<AllServiceResponse> getAllServices() async {
    try {
      Response response = await getHttp(Endpoints.trainerAllService());

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
