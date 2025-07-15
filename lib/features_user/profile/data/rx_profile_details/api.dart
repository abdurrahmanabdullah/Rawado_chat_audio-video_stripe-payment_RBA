import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetProfileDetailsApi {
  static final GetProfileDetailsApi _singleton = GetProfileDetailsApi._internal();
  GetProfileDetailsApi._internal();
  static GetProfileDetailsApi get instance => _singleton;

  Future<ProfileDetailsModel> getProfileDetails() async {
    try {
      Response response = await getHttp(Endpoints.profileDetails());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        ProfileDetailsModel data =
            ProfileDetailsModel.fromRawJson(json.encode(response.data));
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
