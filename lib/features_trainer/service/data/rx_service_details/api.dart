import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/service/model/service_response.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetServicDetailsApi {
  static final GetServicDetailsApi _singleton = GetServicDetailsApi._internal();
  GetServicDetailsApi._internal();
  static GetServicDetailsApi get instance => _singleton;

  Future<CreateServiceResponse> getServiceDetails(int id) async {
    try {
      Response response = await getHttp(Endpoints.serviceDetails(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        CreateServiceResponse data =
            CreateServiceResponse.fromRawJson(json.encode(response.data));
        return data;
      } 
      else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
