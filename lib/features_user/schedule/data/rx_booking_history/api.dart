import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../model/customer_schedule_response.dart';

final class GetBookingHistoryApi {
  static final GetBookingHistoryApi _singleton =
      GetBookingHistoryApi._internal();
  GetBookingHistoryApi._internal();
  static GetBookingHistoryApi get instance => _singleton;

  Future<CustomerScheduleResponse> getBookedHistory() async {
    try {
      Response response = await getHttp(Endpoints.customerHistory());

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
