import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../model/user_review_response.dart';

final class GetUserReviewApi {
  static final GetUserReviewApi _singleton = GetUserReviewApi._internal();
  GetUserReviewApi._internal();
  static GetUserReviewApi get instance => _singleton;

 Future<UserReviewResponse> getUserReview(int page) async {
  try {

    Response response = await getHttp(Endpoints.userReview(page) );

    log('response status code : ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      UserReviewResponse responseData = UserReviewResponse.fromRawJson(json.encode(response.data));
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

