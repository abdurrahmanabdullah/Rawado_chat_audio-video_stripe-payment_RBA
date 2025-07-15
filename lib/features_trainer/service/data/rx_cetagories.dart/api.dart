import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/features_trainer/service/model/categories_response.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetCategoriesApi {
  static final GetCategoriesApi _singleton = GetCategoriesApi._internal();
  GetCategoriesApi._internal();
  static GetCategoriesApi get instance => _singleton;

  Future<CategoriesResponse> getCategories() async {
    try {
      Response response = await getHttp(Endpoints.categories());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        CategoriesResponse data =
            CategoriesResponse.fromRawJson(json.encode(response.data));
        return data;
      } 
      // else if (response.statusCode  == 203) {
      //   LoginResponse data = LoginResponse(code: 203);
      //   return data;
      // } else if (response.statusCode == 422) {
      //   LoginResponse data = LoginResponse(code: 422);
      //   return data;
      // } 
      else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
