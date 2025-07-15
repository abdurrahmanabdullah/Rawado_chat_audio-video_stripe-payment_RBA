import 'dart:convert';

class ServiceScheduleTimeResponse {
    bool? status;
    String? message;
    int? code;
    List<String>? data;

    ServiceScheduleTimeResponse({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    ServiceScheduleTimeResponse copyWith({
        bool? status,
        String? message,
        int? code,
        List<String>? data,
    }) => 
        ServiceScheduleTimeResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory ServiceScheduleTimeResponse.fromRawJson(String str) => ServiceScheduleTimeResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceScheduleTimeResponse.fromJson(Map<String, dynamic> json) => ServiceScheduleTimeResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}
