import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/login_response.dart';

final class LoginApi {
  static final LoginApi _singleton = LoginApi._internal();
  LoginApi._internal();
  static LoginApi get instance => _singleton;

  
  Future<LoginResponse> login(String email, String password) async {
    try {
      Map data = {
        "email": email,
        "password": password,
      };

      Response response = await postHttp(Endpoints.logIn(), data);

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
