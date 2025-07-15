import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../model/trainer_rating_response.dart';

final class GetTrainerRatingApi {
  static final GetTrainerRatingApi _singleton = GetTrainerRatingApi._internal();
  GetTrainerRatingApi._internal();
  static GetTrainerRatingApi get instance => _singleton;

  Future<TrainerRatingResponse> trainerRating() async {
    try {
      Response response = await getHttp(Endpoints.trainerRating());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        TrainerRatingResponse responseData =
            TrainerRatingResponse.fromRawJson(json.encode(response.data));
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
