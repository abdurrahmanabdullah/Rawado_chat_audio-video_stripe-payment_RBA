// import 'dart:convert';

// class AllServiceModel {
//   bool? status;
//   int? code;
//   String? message;
//   List<ServiceData>? data;

//   AllServiceModel({
//     this.status,
//     this.code,
//     this.message,
//     this.data,
//   });

//   factory AllServiceModel.fromRawJson(String str) =>
//       AllServiceModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AllServiceModel.fromJson(Map<String, dynamic> json) =>
//       AllServiceModel(
//         status: json["status"],
//         code: json["code"],
//         message: json["message"],
//         data: List<ServiceData>.from(
//             json["data"].map((x) => ServiceData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class ServiceData {
//   int id;
//   int userId;
//   String name;
//   String email;
//   int categoryId;
//   int charge;
//   Location location;
//   String longitude;
//   String latitude;
//   String description;
//   List<Image> images;
//   Status status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String distance;
//   Category category;
//   List<ServiceAvailable> serviceAvailables;
//   List<dynamic> reviews;

//   ServiceData({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.email,
//     required this.categoryId,
//     required this.charge,
//     required this.location,
//     required this.longitude,
//     required this.latitude,
//     required this.description,
//     required this.images,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.distance,
//     required this.category,
//     required this.serviceAvailables,
//     required this.reviews,
//   });

//   factory ServiceData.fromRawJson(String str) =>
//       ServiceData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
//         id: json["id"],
//         userId: json["user_id"],
//         name: json["name"],
//         email: json["email"],
//         categoryId: json["category_id"],
//         charge: json["charge"],
//         location: locationValues.map[json["location"]]!,
//         longitude: json["longitude"],
//         latitude: json["latitude"],
//         description: json["description"],
//         images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
//         status: statusValues.map[json["status"]]!,
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         distance: json["distance"],
//         category: Category.fromJson(json["category"]),
//         serviceAvailables: List<ServiceAvailable>.from(
//             json["service_availables"]
//                 .map((x) => ServiceAvailable.fromJson(x))),
//         reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "name": name,
//         "email": email,
//         "category_id": categoryId,
//         "charge": charge,
//         "location": locationValues.reverse[location],
//         "longitude": longitude,
//         "latitude": latitude,
//         "description": description,
//         "images": List<dynamic>.from(images.map((x) => x.toJson())),
//         "status": statusValues.reverse[status],
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "distance": distance,
//         "category": category.toJson(),
//         "service_availables":
//             List<dynamic>.from(serviceAvailables.map((x) => x.toJson())),
//         "reviews": List<dynamic>.from(reviews.map((x) => x)),
//       };
// }

// class Category {
//   int id;
//   Name name;

//   Category({
//     required this.id,
//     required this.name,
//   });

//   factory Category.fromRawJson(String str) =>
//       Category.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: nameValues.map[json["name"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": nameValues.reverse[name],
//       };
// }

// enum Name { PILATES, STRENGTH, YOGA }

// final nameValues = EnumValues(
//     {"pilates": Name.PILATES, "strength": Name.STRENGTH, "yoga": Name.YOGA});

// class Image {
//   int id;
//   int serviceId;
//   String image;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Image({
//     required this.id,
//     required this.serviceId,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         serviceId: json["service_id"],
//         image: json["image"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_id": serviceId,
//         "image": image,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// enum Location { DHAKA_BANGLADESH }

// final locationValues =
//     EnumValues({"Dhaka, Bangladesh": Location.DHAKA_BANGLADESH});

// class ServiceAvailable {
//   int id;
//   int serviceId;
//   String dateName;
//   String startTime;
//   String endTime;
//   DateTime createdAt;
//   DateTime updatedAt;

//   ServiceAvailable({
//     required this.id,
//     required this.serviceId,
//     required this.dateName,
//     required this.startTime,
//     required this.endTime,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ServiceAvailable.fromRawJson(String str) =>
//       ServiceAvailable.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ServiceAvailable.fromJson(Map<String, dynamic> json) =>
//       ServiceAvailable(
//         id: json["id"],
//         serviceId: json["service_id"],
//         dateName: json["date_name"],
//         startTime: json["start_time"],
//         endTime: json["end_time"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_id": serviceId,
//         "date_name": dateName,
//         "start_time": startTime,
//         "end_time": endTime,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// enum Status { ACTIVE }

// final statusValues = EnumValues({"active": Status.ACTIVE});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
