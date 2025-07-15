import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class VerifyOtpFpApi {
  static final VerifyOtpFpApi _singleton = VerifyOtpFpApi._internal();
  VerifyOtpFpApi._internal();
  static VerifyOtpFpApi get instance => _singleton;
  Future<Map> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      Map data = {
        "email": email,
        "otp": code,
        // "status": "0",
        // "_method": "PUT"
      };

      Response response = await postHttp(Endpoints.verifyOtpFP(), data);

      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (dioError) {
      // Handle Dio-specific errors
      String errorMessage = 'Somthing went wrong';
      if (dioError.response != null) {
        switch (dioError.response!.statusCode) {
          case 400:
            errorMessage = 'Invalid OTP code';
            break;
          case 403:
            // errorMessage = 'Forbidden: ${dioError.response!.data}';
            break;
          case 404:
            // errorMessage = 'Not Found: ${dioError.response!.data}';
            break;
          case 500:
            // errorMessage = 'Internal Server Error: ${dioError.response!.data}';
            break;
          default:
          // errorMessage =
          //     'Unhandled status code: ${dioError.response!.statusCode}';
        }
      } else {
        //  errorMessage = 'Network error: ${dioError.message}';
      }
      // Display toast with the error message
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      throw CustomException(errorMessage);
    } catch (error) {
      // Handle generic errors

      throw ErrorHandler.handle(error).failure;
    }
  }
}

// Example custom exception class
class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  @override
  String toString() => 'CustomException: $message';
}
