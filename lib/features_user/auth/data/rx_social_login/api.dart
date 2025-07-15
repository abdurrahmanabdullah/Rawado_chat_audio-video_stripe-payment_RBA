import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/login_response.dart';

final class PostSocialLoginApi {
  static final PostSocialLoginApi _singleton = PostSocialLoginApi._internal();
  PostSocialLoginApi._internal();
  static PostSocialLoginApi get instance => _singleton;

  Future<LoginResponse> socialLogin(String token) async {
    try {
      Map data = {
        "token": token,
        "provider": 'google',
      };

      Response response = await postHttp(Endpoints.socialLogin(), data);

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        LoginResponse data =
            LoginResponse.fromRawJson(json.encode(response.data));
        return data;
      } else if (response.statusCode == 203) {
        LoginResponse data = LoginResponse(code: 203);
        return data;
      } else if (response.statusCode == 422) {
        LoginResponse data = LoginResponse(code: 422);
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
      // ErrorHandler.handle(error).failure.resonseCode;
    }
  }
}
