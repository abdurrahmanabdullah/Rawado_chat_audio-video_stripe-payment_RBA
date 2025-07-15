import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/service/model/schedule_response.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostAddScheduleApi {
  static final PostAddScheduleApi _singleton = PostAddScheduleApi._internal();
  PostAddScheduleApi._internal();
  static PostAddScheduleApi get instance => _singleton;

 Future<ScheduleResponnse> scheduleCreate({required Map body}) async {
  try {

    Response response = await postHttp(Endpoints.scheduleCreate(), body );

    log('response status code : ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScheduleResponnse responseData = ScheduleResponnse.fromRawJson(json.encode(response.data));
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

