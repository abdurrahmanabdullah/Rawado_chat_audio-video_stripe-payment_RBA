import 'dart:convert';

class SignUpResponse {
  bool? status;
  String? message;
  int? code;
  String? tokenType;
  String? token;
  int? expiresIn;
  Data? data;

  SignUpResponse({
    this.status,
    this.message,
    this.code,
    this.tokenType,
    this.token,
    this.expiresIn,
    this.data,
  });

  SignUpResponse copyWith({
    bool? status,
    String? message,
    int? code,
    String? tokenType,
    String? token,
    int? expiresIn,
    Data? data,
  }) =>
      SignUpResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        code: code ?? this.code,
        tokenType: tokenType ?? this.tokenType,
        token: token ?? this.token,
        expiresIn: expiresIn ?? this.expiresIn,
        data: data ?? this.data,
      );

  factory SignUpResponse.fromRawJson(String str) =>
      SignUpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
  String? name;
  String? email;
  String? phone;
  String? role;
  int? id;

  Data({
    this.name,
    this.email,
    this.phone,
    this.role,
    this.id,
  });

  Data copyWith({
    String? name,
    String? email,
    String? phone,
    String? role,
    int? id,
  }) =>
      Data(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        id: id ?? this.id,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "id": id,
      };
}
