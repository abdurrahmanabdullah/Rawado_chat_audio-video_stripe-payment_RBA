import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostTrainerBookinActionApi {
  static final PostTrainerBookinActionApi _singleton =
      PostTrainerBookinActionApi._internal();
  PostTrainerBookinActionApi._internal();
  static PostTrainerBookinActionApi get instance => _singleton;

  Future<Map> changeStatus({required int id, required String status}) async {
    try {
      Response response = await postHttp(
          Endpoints.trainerBookingAction(id), {'status': status});

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseData = json.decode(json.encode(response.data));
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
