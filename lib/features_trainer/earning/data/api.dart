import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetTrainerEarningApi {
  static final GetTrainerEarningApi _singleton =
      GetTrainerEarningApi._internal();
  GetTrainerEarningApi._internal();
  static GetTrainerEarningApi get instance => _singleton;
  Future<Map> getEarning(int id) async {
    try {
      Response response = await getHttp(
        Endpoints.earningUrl(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      throw ErrorHandler.handle(error).failure;
    }
  }
}
