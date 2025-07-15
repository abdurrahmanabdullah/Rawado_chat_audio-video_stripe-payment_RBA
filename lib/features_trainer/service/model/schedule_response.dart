import 'dart:convert';

class ScheduleResponnse {
    bool? status;
    int? code;
    String? message;
    AvailavleServiceData? data;

    ScheduleResponnse({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    ScheduleResponnse copyWith({
        bool? status,
        int? code,
        String? message,
        AvailavleServiceData? data,
    }) => 
        ScheduleResponnse(
            status: status ?? this.status,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ScheduleResponnse.fromRawJson(String str) => ScheduleResponnse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ScheduleResponnse.fromJson(Map<String, dynamic> json) => ScheduleResponnse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : AvailavleServiceData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class AvailavleServiceData {
    int? serviceId;
    String? dateName;
    String? startTime;
    String? endTime;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    AvailavleServiceData({
        this.serviceId,
        this.dateName,
        this.startTime,
        this.endTime,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    AvailavleServiceData copyWith({
        int? serviceId,
        String? dateName,
        String? startTime,
        String? endTime,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        AvailavleServiceData(
            serviceId: serviceId ?? this.serviceId,
            dateName: dateName ?? this.dateName,
            startTime: startTime ?? this.startTime,
            endTime: endTime ?? this.endTime,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory AvailavleServiceData.fromRawJson(String str) => AvailavleServiceData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AvailavleServiceData.fromJson(Map<String, dynamic> json) => AvailavleServiceData(
        serviceId: json["service_id"],
        dateName: json["date_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "date_name": dateName,
        "start_time": startTime,
        "end_time": endTime,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
