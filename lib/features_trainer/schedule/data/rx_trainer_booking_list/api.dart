import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/schedule/model/trainer_booking_list.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetTrainerBookingListApi {
  static final GetTrainerBookingListApi _singleton =
      GetTrainerBookingListApi._internal();
  GetTrainerBookingListApi._internal();
  static GetTrainerBookingListApi get instance => _singleton;

  Future<TrainerBookingResponse> getBookedlist() async {
    try {
      Response response = await getHttp(Endpoints.getTrainerBookingList());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        TrainerBookingResponse data =
            TrainerBookingResponse.fromRawJson(json.encode(response.data));
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
