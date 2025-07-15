import 'dart:convert';

class SingleServiceResponse {
  bool? status;
  int? code;
  String? message;
  Data? data;

  SingleServiceResponse({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory SingleServiceResponse.fromRawJson(String str) =>
      SingleServiceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleServiceResponse.fromJson(Map<String, dynamic> json) =>
      SingleServiceResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int id;
  int userId;
  String name;
  String email;
  int categoryId;
  int charge;
  String location;
  String longitude;
  String latitude;
  String description;
  List<Image> images;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String distance;
  Category category;
  List<ServiceAvailable> serviceAvailables;
  List<dynamic> reviews;

  Data({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.categoryId,
    required this.charge,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.description,
    required this.images,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.distance,
    required this.category,
    required this.serviceAvailables,
    required this.reviews,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        categoryId: json["category_id"],
        charge: json["charge"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        description: json["description"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        distance: json["distance"],
        category: Category.fromJson(json["category"]),
        serviceAvailables: List<ServiceAvailable>.from(
            json["service_availables"]
                .map((x) => ServiceAvailable.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "category_id": categoryId,
        "charge": charge,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "distance": distance,
        "category": category.toJson(),
        "service_availables":
            List<dynamic>.from(serviceAvailables.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
      };
}

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Image {
  int id;
  int serviceId;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Image({
    required this.id,
    required this.serviceId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        serviceId: json["service_id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ServiceAvailable {
  int id;
  int serviceId;
  String dateName;
  String startTime;
  String endTime;
  DateTime createdAt;
  DateTime updatedAt;

  ServiceAvailable({
    required this.id,
    required this.serviceId,
    required this.dateName,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceAvailable.fromRawJson(String str) =>
      ServiceAvailable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceAvailable.fromJson(Map<String, dynamic> json) =>
      ServiceAvailable(
        id: json["id"],
        serviceId: json["service_id"],
        dateName: json["date_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "date_name": dateName,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
