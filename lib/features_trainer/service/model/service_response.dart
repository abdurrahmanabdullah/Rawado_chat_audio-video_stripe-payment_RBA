import 'dart:convert';

class CreateServiceResponse {
    bool? status;
    int? code;
    String? message;
    Data? data;

    CreateServiceResponse({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    CreateServiceResponse copyWith({
        bool? status,
        int? code,
        String? message,
        Data? data,
    }) => 
        CreateServiceResponse(
            status: status ?? this.status,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory CreateServiceResponse.fromRawJson(String str) => CreateServiceResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreateServiceResponse.fromJson(Map<String, dynamic> json) => CreateServiceResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
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
    List<ImageData>? images;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? distance;
    Category? category;
    List<dynamic>? serviceAvailables;
    List<dynamic>? reviews;

    Data({
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
        this.category,
        this.serviceAvailables,
        this.reviews,
    });

    Data copyWith({
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
        List<ImageData>? images,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? distance,
        Category? category,
        List<dynamic>? serviceAvailables,
        List<dynamic>? reviews,
    }) => 
        Data(
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
            category: category ?? this.category,
            serviceAvailables: serviceAvailables ?? this.serviceAvailables,
            reviews: reviews ?? this.reviews,
        );

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
        images: json["images"] == null ? [] : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromJson(x))),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        distance: json["distance"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        serviceAvailables: json["service_availables"] == null ? [] : List<dynamic>.from(json["service_availables"]!.map((x) => x)),
        reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
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
        "category": category?.toJson(),
        "service_availables": serviceAvailables == null ? [] : List<dynamic>.from(serviceAvailables!.map((x) => x)),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
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

class ImageData {
    int? id;
    int? serviceId;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    ImageData({
        this.id,
        this.serviceId,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    ImageData copyWith({
        int? id,
        int? serviceId,
        String? image,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ImageData(
            id: id ?? this.id,
            serviceId: serviceId ?? this.serviceId,
            image: image ?? this.image,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ImageData.fromRawJson(String str) => ImageData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
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
