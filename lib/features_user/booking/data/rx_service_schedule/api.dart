import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/service_schedule_time_response.dart';

final class GetServiceScheduleApi {
  static final GetServiceScheduleApi _singleton = GetServiceScheduleApi._internal();
  GetServiceScheduleApi._internal();
  static GetServiceScheduleApi get instance => _singleton;

  Future<ServiceScheduleTimeResponse> getSchedule(int id, String date) async {
    try {
      Response response = await getHttp(Endpoints.getScheduleTime(id, date));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        ServiceScheduleTimeResponse data =
            ServiceScheduleTimeResponse.fromRawJson(json.encode(response.data));
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
