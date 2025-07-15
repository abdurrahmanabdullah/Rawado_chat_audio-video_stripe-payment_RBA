import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../model/customer_schedule_response.dart';

final class GetCustomerScheduleApi {
  static final GetCustomerScheduleApi _singleton =
      GetCustomerScheduleApi._internal();
  GetCustomerScheduleApi._internal();
  static GetCustomerScheduleApi get instance => _singleton;

  Future<CustomerScheduleResponse> getBookedSchedule() async {
    try {
      Response response = await getHttp(Endpoints.pendingSchedule());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        CustomerScheduleResponse data =
            CustomerScheduleResponse.fromRawJson(json.encode(response.data));
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
