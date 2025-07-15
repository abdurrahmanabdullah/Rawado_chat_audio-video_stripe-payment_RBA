import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/available_response.dart';

final class GetAvailableServiceApi {
  static final GetAvailableServiceApi _singleton =
      GetAvailableServiceApi._internal();
  GetAvailableServiceApi._internal();
  static GetAvailableServiceApi get instance => _singleton;

  Future<AvailableServiceResponse> getAvailableServices(int id) async {
    try {
      Response response = await getHttp(Endpoints.availableService(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        AvailableServiceResponse data =
            AvailableServiceResponse.fromRawJson(json.encode(response.data));
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
