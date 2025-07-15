import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetDirectionApiApi {
  static final GetDirectionApiApi _singleton = GetDirectionApiApi._internal();
  GetDirectionApiApi._internal();
  static GetDirectionApiApi get instance => _singleton;

  Future<Map<String, dynamic>> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      Response response = await getHttp(
          'https://maps.googleapis.com/maps/api/directions/json?destination=${'${destination.latitude},${destination.longitude}'}&origin=${'${origin.latitude},${origin.longitude}'}&key=${dotenv.env['GOOGLE_MAP_KEY']!}');

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData =
            json.decode(json.encode(response.data));
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
