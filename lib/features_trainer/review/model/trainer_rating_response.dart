import 'dart:convert';

class TrainerRatingResponse {
  bool? status;
  String? message;
  int? code;
  RatingData? data;

  TrainerRatingResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  TrainerRatingResponse copyWith({
    bool? status,
    String? message,
    int? code,
    RatingData? data,
  }) =>
      TrainerRatingResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory TrainerRatingResponse.fromRawJson(String str) =>
      TrainerRatingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrainerRatingResponse.fromJson(Map<String, dynamic> json) =>
      TrainerRatingResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : RatingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
      };
}

class RatingData {
  int? total;
  dynamic? average;
  Map<String, double>? data;

  RatingData({
    this.total,
    this.average,
    this.data,
  });

  RatingData copyWith({
    int? total,
    double? average,
    Map<String, double>? data,
  }) =>
      RatingData(
        total: total ?? this.total,
        average: average ?? this.average,
        data: data ?? this.data,
      );

  factory RatingData.fromRawJson(String str) =>
      RatingData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingData.fromJson(Map<String, dynamic> json) => RatingData(
        total: json["total"],
        average: json["average"]?.toDouble(),
        data: Map.from(json["data"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "average": average,
        "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
