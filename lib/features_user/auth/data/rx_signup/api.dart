import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rawado/features_user/auth/model/signup_response.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class SignUpApi {
  static final SignUpApi _singleton = SignUpApi._internal();
  SignUpApi._internal();
  static SignUpApi get instance => _singleton;
  Future<SignUpResponse> signUp(
      {required String name,
      required String phone,
      required String email,
      required String role,
      required String password,
      required String retypePw,
      required String gender}) async {
    try {
      Map data = {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "role": role,
        "password_confirmation": retypePw,
        "gender": gender.toLowerCase()
      };
      Response response = await postHttp(Endpoints.signUp(), data);
      if (response.statusCode == 200) {
        SignUpResponse data =
            SignUpResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
      // ErrorHandler.handle(error).failure;
    }
  }
}
