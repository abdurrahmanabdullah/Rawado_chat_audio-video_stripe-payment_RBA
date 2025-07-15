import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetSearchApi {
  static final GetSearchApi _singleton =
      GetSearchApi._internal();
  GetSearchApi._internal();
  static GetSearchApi get instance => _singleton;

  Future<AllServiceResponse> search({required String  searchQueary}) async {
    try {
      Response response = await getHttp(Endpoints.customerSearch(searchQueary));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        AllServiceResponse responseData = AllServiceResponse.fromRawJson(json.encode(response.data));
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
