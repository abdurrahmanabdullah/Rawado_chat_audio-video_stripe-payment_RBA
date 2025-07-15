import 'dart:convert';

class AllServiceResponse {
    bool? status;
    int? code;
    String? message;
    List<ServiceData>? data;

    AllServiceResponse({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    AllServiceResponse copyWith({
        bool? status,
        int? code,
        String? message,
        List<ServiceData>? data,
    }) => 
        AllServiceResponse(
            status: status ?? this.status,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory AllServiceResponse.fromRawJson(String str) => AllServiceResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllServiceResponse.fromJson(Map<String, dynamic> json) => AllServiceResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ServiceData>.from(json["data"]!.map((x) => ServiceData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ServiceData {
    int? id;
    int? userId;
    String? name;
    String? email;
    int? categoryId;
    int? charge;
    String? location;
    String? longitude;
    String? latitude;
    String? description;
    List<Images>? images;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? distance;
    double? totalRatingAverage;
    Category? category;
    List<ServiceAvailable>? serviceAvailables;
    List<Reviews>? reviews;

    ServiceData({
        this.id,
        this.userId,
        this.name,
        this.email,
        this.categoryId,
        this.charge,
        this.location,
        this.longitude,
        this.latitude,
        this.description,
        this.images,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.distance,
        this.totalRatingAverage,
        this.category,
        this.serviceAvailables,
        this.reviews,
    });

    ServiceData copyWith({
        int? id,
        int? userId,
        String? name,
        String? email,
        int? categoryId,
        int? charge,
        String? location,
        String? longitude,
        String? latitude,
        String? description,
        List<Images>? images,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? distance,
        double? totalRatingAverage,
        Category? category,
        List<ServiceAvailable>? serviceAvailables,
        List<Reviews>? reviews,
    }) => 
        ServiceData(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            email: email ?? this.email,
            categoryId: categoryId ?? this.categoryId,
            charge: charge ?? this.charge,
            location: location ?? this.location,
            longitude: longitude ?? this.longitude,
            latitude: latitude ?? this.latitude,
            description: description ?? this.description,
            images: images ?? this.images,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            distance: distance ?? this.distance,
            totalRatingAverage: totalRatingAverage ?? this.totalRatingAverage,
            category: category ?? this.category,
            serviceAvailables: serviceAvailables ?? this.serviceAvailables,
            reviews: reviews ?? this.reviews,
        );

    factory ServiceData.fromRawJson(String str) => ServiceData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
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
        images: json["images"] == null ? [] : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        distance: json["distance"],
        totalRatingAverage: json["total_rating_average"]?.toDouble(),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        serviceAvailables: json["service_availables"] == null ? [] : List<ServiceAvailable>.from(json["service_availables"]!.map((x) => ServiceAvailable.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<Reviews>.from(json["reviews"]!.map((x) => Reviews.fromJson(x))),
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
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "distance": distance,
        "total_rating_average": totalRatingAverage,
        "category": category?.toJson(),
        "service_availables": serviceAvailables == null ? [] : List<dynamic>.from(serviceAvailables!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    };
}

class Category {
    int? id;
    String? name;

    Category({
        this.id,
        this.name,
    });

    Category copyWith({
        int? id,
        String? name,
    }) => 
        Category(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

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

class Images {
    int? id;
    int? serviceId;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    Images({
        this.id,
        this.serviceId,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    Images copyWith({
        int? id,
        int? serviceId,
        String? image,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Images(
            id: id ?? this.id,
            serviceId: serviceId ?? this.serviceId,
            image: image ?? this.image,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        serviceId: json["service_id"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Reviews {
    int? id;
    int? userId;
    int? serviceId;
    String? message;
    double? rating;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    Reviews({
        this.id,
        this.userId,
        this.serviceId,
        this.message,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    Reviews copyWith({
        int? id,
        int? userId,
        int? serviceId,
        String? message,
        double? rating,
        DateTime? createdAt,
        DateTime? updatedAt,
        User? user,
    }) => 
        Reviews(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            serviceId: serviceId ?? this.serviceId,
            message: message ?? this.message,
            rating: rating ?? this.rating,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
        );

    factory Reviews.fromRawJson(String str) => Reviews.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        message: json["message"],
        rating: json["rating"]?.toDouble(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_id": serviceId,
        "message": message,
        "rating": rating,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? avatar;

    User({
        this.id,
        this.name,
        this.avatar,
    });

    User copyWith({
        int? id,
        String? name,
        String? avatar,
    }) => 
        User(
            id: id ?? this.id,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
    };
}

// class Reviews {
//     int? id;
//     int? userId;
//     int? serviceId;
//     String? message;
//     double? rating;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     Reviews({
//         this.id,
//         this.userId,
//         this.serviceId,
//         this.message,
//         this.rating,
//         this.createdAt,
//         this.updatedAt,
//     });

//     Reviews copyWith({
//         int? id,
//         int? userId,
//         int? serviceId,
//         String? message,
//         double? rating,
//         DateTime? createdAt,
//         DateTime? updatedAt,
//     }) => 
//         Reviews(
//             id: id ?? this.id,
//             userId: userId ?? this.userId,
//             serviceId: serviceId ?? this.serviceId,
//             message: message ?? this.message,
//             rating: rating ?? this.rating,
//             createdAt: createdAt ?? this.createdAt,
//             updatedAt: updatedAt ?? this.updatedAt,
//         );

//     factory Reviews.fromRawJson(String str) => Reviews.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
//         id: json["id"],
//         userId: json["user_id"],
//         serviceId: json["service_id"],
//         message: json["message"],
//         rating: json["rating"]?.toDouble(),
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "service_id": serviceId,
//         "message": message,
//         "rating": rating,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }

class ServiceAvailable {
    int? id;
    int? serviceId;
    String? dateName;
    String? startTime;
    String? endTime;
    DateTime? createdAt;
    DateTime? updatedAt;

    ServiceAvailable({
        this.id,
        this.serviceId,
        this.dateName,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
    });

    ServiceAvailable copyWith({
        int? id,
        int? serviceId,
        String? dateName,
        String? startTime,
        String? endTime,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ServiceAvailable(
            id: id ?? this.id,
            serviceId: serviceId ?? this.serviceId,
            dateName: dateName ?? this.dateName,
            startTime: startTime ?? this.startTime,
            endTime: endTime ?? this.endTime,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ServiceAvailable.fromRawJson(String str) => ServiceAvailable.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceAvailable.fromJson(Map<String, dynamic> json) => ServiceAvailable(
        id: json["id"],
        serviceId: json["service_id"],
        dateName: json["date_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "date_name": dateName,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}



// import 'dart:convert';

// class AllServiceResponse {
//   bool? status;
//   int? code;
//   String? message;
//   List<ServiceData>? data;

//   AllServiceResponse({
//     this.status,
//     this.code,
//     this.message,
//     this.data,
//   });

//   AllServiceResponse copyWith({
//     bool? status,
//     int? code,
//     String? message,
//     List<ServiceData>? data,
//   }) =>
//       AllServiceResponse(
//         status: status ?? this.status,
//         code: code ?? this.code,
//         message: message ?? this.message,
//         data: data ?? this.data,
//       );

//   factory AllServiceResponse.fromRawJson(String str) =>
//       AllServiceResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AllServiceResponse.fromJson(Map<String, dynamic> json) =>
//       AllServiceResponse(
//         status: json["status"],
//         code: json["code"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<ServiceData>.from(
//                 json["data"]!.map((x) => ServiceData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class ServiceData {
//   int? id;
//   int? userId;
//   String? name;
//   String? email;
//   int? categoryId;
//   int? charge;
//   String? location;
//   String? longitude;
//   String? latitude;
//   String? description;
//   List<Images>? images;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? distance;
//   Category? category;

//   double? totalRatingAverage;
//   List<ServiceAvailable>? serviceAvailables;
//   List<Reviews>? reviews;

//   ServiceData({
//     this.id,
//     this.userId,
//     this.name,
//     this.email,
//     this.categoryId,
//     this.charge,
//     this.location,
//     this.longitude,
//     this.latitude,
//     this.description,
//     this.images,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.distance,
//     this.category,
//     this.totalRatingAverage,
//     this.serviceAvailables,
//     this.reviews,
//   });

//   ServiceData copyWith({
//     int? id,
//     int? userId,
//     String? name,
//     String? email,
//     int? categoryId,
//     int? charge,
//     String? location,
//     String? longitude,
//     String? latitude,
//     String? description,
//     List<Images>? images,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? distance,
//     Category? category,
//     double? totalRatingAverage,
//     List<ServiceAvailable>? serviceAvailables,
//     List<Reviews>? reviews,
//   }) =>
//       ServiceData(
//         id: id ?? this.id,
//         userId: userId ?? this.userId,
//         name: name ?? this.name,
//         email: email ?? this.email,
//         categoryId: categoryId ?? this.categoryId,
//         charge: charge ?? this.charge,
//         location: location ?? this.location,
//         longitude: longitude ?? this.longitude,
//         latitude: latitude ?? this.latitude,
//         description: description ?? this.description,
//         images: images ?? this.images,
//         status: status ?? this.status,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         distance: distance ?? this.distance,
//         category: category ?? this.category,
//         totalRatingAverage: totalRatingAverage ?? this.totalRatingAverage,
//         serviceAvailables: serviceAvailables ?? this.serviceAvailables,
//         reviews: reviews ?? this.reviews,
//       );

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
//         location: json["location"],
//         longitude: json["longitude"],
//         latitude: json["latitude"],
//         description: json["description"],
//         images: json["images"] == null
//             ? []
//             : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         distance: json["distance"],
//         category: json["category"] == null
//             ? null
//             : Category.fromJson(json["category"]),
//         totalRatingAverage: json["total_rating_average"],
//         serviceAvailables: json["service_availables"] == null
//             ? []
//             : List<ServiceAvailable>.from(json["service_availables"]!
//                 .map((x) => ServiceAvailable.fromJson(x))),
//         reviews: json["reviews"] == null
//             ? []
//             : List<Reviews>.from(
//                 json["reviews"]!.map((x) => Reviews.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "name": name,
//         "email": email,
//         "category_id": categoryId,
//         "charge": charge,
//         "location": location,
//         "longitude": longitude,
//         "latitude": latitude,
//         "description": description,
//         "images": images == null
//             ? []
//             : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "distance": distance,
//         "category": category?.toJson(),
//         "total_rating_average": totalRatingAverage,
//         "service_availables": serviceAvailables == null
//             ? []
//             : List<dynamic>.from(serviceAvailables!.map((x) => x.toJson())),
//         "reviews": reviews == null
//             ? []
//             : List<dynamic>.from(reviews!.map((x) => x.toJson())),
//       };
// }

// class Category {
//   int? id;
//   String? name;

//   Category({
//     this.id,
//     this.name,
//   });

//   Category copyWith({
//     int? id,
//     String? name,
//   }) =>
//       Category(
//         id: id ?? this.id,
//         name: name ?? this.name,
//       );

//   factory Category.fromRawJson(String str) =>
//       Category.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }

// class Images {
//   int? id;
//   int? serviceId;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Images({
//     this.id,
//     this.serviceId,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Images copyWith({
//     int? id,
//     int? serviceId,
//     String? image,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) =>
//       Images(
//         id: id ?? this.id,
//         serviceId: serviceId ?? this.serviceId,
//         image: image ?? this.image,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );

//   factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Images.fromJson(Map<String, dynamic> json) => Images(
//         id: json["id"],
//         serviceId: json["service_id"],
//         image: json["image"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_id": serviceId,
//         "image": image,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }

// class Reviews {
//   int? id;
//   int? userId;
//   int? serviceId;
//   String? message;
//   double? rating;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Reviews({
//     this.id,
//     this.userId,
//     this.serviceId,
//     this.message,
//     this.rating,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Reviews copyWith({
//     int? id,
//     int? userId,
//     int? serviceId,
//     String? message,
//     double? rating,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) =>
//       Reviews(
//         id: id ?? this.id,
//         userId: userId ?? this.userId,
//         serviceId: serviceId ?? this.serviceId,
//         message: message ?? this.message,
//         rating: rating ?? this.rating,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );

//   factory Reviews.fromRawJson(String str) => Reviews.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
//         id: json["id"],
//         userId: json["user_id"],
//         serviceId: json["service_id"],
//         message: json["message"],
//         rating: json["rating"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "service_id": serviceId,
//         "message": message,
//         "rating": rating,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }

// class ServiceAvailable {
//   int? id;
//   int? serviceId;
//   String? dateName;
//   String? startTime;
//   String? endTime;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   ServiceAvailable({
//     this.id,
//     this.serviceId,
//     this.dateName,
//     this.startTime,
//     this.endTime,
//     this.createdAt,
//     this.updatedAt,
//   });

//   ServiceAvailable copyWith({
//     int? id,
//     int? serviceId,
//     String? dateName,
//     String? startTime,
//     String? endTime,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) =>
//       ServiceAvailable(
//         id: id ?? this.id,
//         serviceId: serviceId ?? this.serviceId,
//         dateName: dateName ?? this.dateName,
//         startTime: startTime ?? this.startTime,
//         endTime: endTime ?? this.endTime,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );

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
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_id": serviceId,
//         "date_name": dateName,
//         "start_time": startTime,
//         "end_time": endTime,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
