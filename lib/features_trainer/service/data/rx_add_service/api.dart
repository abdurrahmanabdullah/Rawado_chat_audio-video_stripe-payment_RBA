import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../model/service_response.dart';

final class PostServiceCreteApi {
  static final PostServiceCreteApi _singleton = PostServiceCreteApi._internal();
  PostServiceCreteApi._internal();
  static PostServiceCreteApi get instance => _singleton;

 Future<CreateServiceResponse> serviceCreate({required String name,required String email, required int categoryId,required String charge,required String lat,required  String lon,required String desc,required  String locaation,required List<File> imagePaths,}) async {
  try {
// Convert list of images to FormData file entries
    var images = <MultipartFile>[];
      for (var path in imagePaths) {
        // Check if the file exists before adding it
        if (await path.exists()) {
          String fileName = path.path.split('/').last;
          images.add(await MultipartFile.fromFile(path.path,
              filename: '${DateTime.now().millisecond}_$fileName'));
        } else {
          throw Exception('File not found: ${path.path}');
        }
      }
    // Convert the Map data to FormData
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "category_id": categoryId,
      "charge":charge,
      "location": locaation,
      "longitude": lon,
      "latitude": lat,
      "description": desc,
      "images[]": images
    });

    Response response = await postHttp(Endpoints.serviceCreate(), formData);

    log('response status code : ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      CreateServiceResponse responseData = CreateServiceResponse.fromRawJson(json.encode(response.data));
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

