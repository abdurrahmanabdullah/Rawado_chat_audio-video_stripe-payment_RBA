import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/single_service_response.dart';

final class GetSingleServicesApi {
  static final GetSingleServicesApi _singleton =
      GetSingleServicesApi._internal();
  GetSingleServicesApi._internal();
  static GetSingleServicesApi get instance => _singleton;

  Future<SingleServiceResponse> getSignleServices(int id) async {
    try {
      Response response = await getHttp(Endpoints.signleService(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        SingleServiceResponse data =
            SingleServiceResponse.fromRawJson(json.encode(response.data));
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
