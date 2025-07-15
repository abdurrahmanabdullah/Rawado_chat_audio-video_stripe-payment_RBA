
// //azad added...

// import 'dart:convert';

// class ProfileDetailsModel {
//     bool? status;
//     String? message;
//     int? code;
//     Data? data;

//     ProfileDetailsModel({
//          this.status,
//          this.message,
//          this.code,
//          this.data,
//     });

//     factory ProfileDetailsModel.fromRawJson(String str) => ProfileDetailsModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => ProfileDetailsModel(
//         status: json["status"],
//         message: json["message"],
//         code: json["code"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "code": code,
//         "data": data?.toJson(),
//     };
// }

// class Data {
//     int id;
//     String name;
//     String email;
//     String phone;
//     dynamic address;
//     dynamic longitude;
//     dynamic latitude;
//     dynamic avatar;
//     String role;
//     String status;
//     String isNew;
//     String available;
//     String gender;

//     Data({
//         required this.id,
//         required this.name,
//         required this.email,
//         required this.phone,
//         required this.address,
//         required this.longitude,
//         required this.latitude,
//         required this.avatar,
//         required this.role,
//         required this.status,
//         required this.isNew,
//         required this.available,
//         required this.gender,
//     });

//     factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         address: json["address"],
//         longitude: json["longitude"],
//         latitude: json["latitude"],
//         avatar: json["avatar"],
//         role: json["role"],
//         status: json["status"],
//         isNew: json["is_new"],
//         available: json["available"],
//         gender: json["gender"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "address": address,
//         "longitude": longitude,
//         "latitude": latitude,
//         "avatar": avatar,
//         "role": role,
//         "status": status,
//         "is_new": isNew,
//         "available": available,
//         "gender": gender,
//     };
// }

import 'dart:convert';

class ProfileDetailsModel {
    bool? status;
    String? message;
    int? code;
    ProfileData? data;

    ProfileDetailsModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    ProfileDetailsModel copyWith({
        bool? status,
        String? message,
        int? code,
        ProfileData? data,
    }) => 
        ProfileDetailsModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory ProfileDetailsModel.fromRawJson(String str) => ProfileDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => ProfileDetailsModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
    };
}

class ProfileData {
    int? id;
    String? name;
    String? email;
    dynamic phone;
    dynamic address;
    dynamic longitude;
    dynamic latitude;
    dynamic avatar;
    String? role;
    String? status;
    String? isNew;
    String? available;
    String? gender;

    ProfileData({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.longitude,
        this.latitude,
        this.avatar,
        this.role,
        this.status,
        this.isNew,
        this.available,
        this.gender,
    });

    ProfileData copyWith({
        int? id,
        String? name,
        String? email,
        dynamic phone,
        dynamic address,
        dynamic longitude,
        dynamic latitude,
        dynamic avatar,
        String? role,
        String? status,
        String? isNew,
        String? available,
        String? gender,
    }) => 
        ProfileData(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            address: address ?? this.address,
            longitude: longitude ?? this.longitude,
            latitude: latitude ?? this.latitude,
            avatar: avatar ?? this.avatar,
            role: role ?? this.role,
            status: status ?? this.status,
            isNew: isNew ?? this.isNew,
            available: available ?? this.available,
            gender: gender ?? this.gender,
        );

    factory ProfileData.fromRawJson(String str) => ProfileData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        avatar: json["avatar"],
        role: json["role"],
        status: json["status"],
        isNew: json["is_new"],
        available: json["available"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "avatar": avatar,
        "role": role,
        "status": status,
        "is_new": isNew,
        "available": available,
        "gender": gender,
    };
}
