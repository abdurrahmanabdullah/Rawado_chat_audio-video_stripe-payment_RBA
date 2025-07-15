import 'dart:convert';

class LoginResponse {
    bool? status;
    String? message;
    int? code;
    String? tokenType;
    String? token;
    int? expiresIn;
    Data? data;

    LoginResponse({
        this.status,
        this.message,
        this.code,
        this.tokenType,
        this.token,
        this.expiresIn,
        this.data,
    });

    LoginResponse copyWith({
        bool? status,
        String? message,
        int? code,
        String? tokenType,
        String? token,
        int? expiresIn,
        Data? data,
    }) => 
        LoginResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            tokenType: tokenType ?? this.tokenType,
            token: token ?? this.token,
            expiresIn: expiresIn ?? this.expiresIn,
            data: data ?? this.data,
        );

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        tokenType: json["token_type"],
        token: json["token"],
        expiresIn: json["expires_in"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "token_type": tokenType,
        "token": token,
        "expires_in": expiresIn,
        "data": data?.toJson(),
    };
}

class Data {
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

    Data({
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

    Data copyWith({
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
        Data(
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

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
