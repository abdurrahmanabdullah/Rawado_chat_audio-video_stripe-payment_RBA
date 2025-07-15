import 'dart:convert';

import 'package:rawado/features_trainer/service/model/schedule_response.dart';

class AvailableServiceResponse {
  bool? status;
  int? code;
  String? message;
  List<AvailavleServiceData>? data;

  AvailableServiceResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AvailableServiceResponse.fromRawJson(String str) =>
      AvailableServiceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AvailableServiceResponse.fromJson(Map<String, dynamic> json) =>
      AvailableServiceResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<AvailavleServiceData>.from(
            json["data"].map((x) => AvailavleServiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

