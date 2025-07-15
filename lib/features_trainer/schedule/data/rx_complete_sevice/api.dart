import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostTrainerRescheduleActionApi {
  static final PostTrainerRescheduleActionApi _singleton =
      PostTrainerRescheduleActionApi._internal();
  PostTrainerRescheduleActionApi._internal();
  static PostTrainerRescheduleActionApi get instance => _singleton;

  Future<Map> changeRescheduleStatus({required int id}) async {
    try {
      Response response = await postHttp(Endpoints.trainerRescheduleAction(id));

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
