import 'dart:convert';

class UserReviewResponse {
    bool? status;
    String? message;
    int? code;
    ReviewResponse? data;

    UserReviewResponse({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    UserReviewResponse copyWith({
        bool? status,
        String? message,
        int? code,
        ReviewResponse? data,
    }) => 
        UserReviewResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory UserReviewResponse.fromRawJson(String str) => UserReviewResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserReviewResponse.fromJson(Map<String, dynamic> json) => UserReviewResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : ReviewResponse.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
    };
}

class ReviewResponse {
    int? currentPage;
    List<ReviewData>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    ReviewResponse({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    ReviewResponse copyWith({
        int? currentPage,
        List<ReviewData>? data,
        String? firstPageUrl,
        int? from,
        int? lastPage,
        String? lastPageUrl,
        List<Link>? links,
        dynamic nextPageUrl,
        String? path,
        int? perPage,
        dynamic prevPageUrl,
        int? to,
        int? total,
    }) => 
        ReviewResponse(
            currentPage: currentPage ?? this.currentPage,
            data: data ?? this.data,
            firstPageUrl: firstPageUrl ?? this.firstPageUrl,
            from: from ?? this.from,
            lastPage: lastPage ?? this.lastPage,
            lastPageUrl: lastPageUrl ?? this.lastPageUrl,
            links: links ?? this.links,
            nextPageUrl: nextPageUrl ?? this.nextPageUrl,
            path: path ?? this.path,
            perPage: perPage ?? this.perPage,
            prevPageUrl: prevPageUrl ?? this.prevPageUrl,
            to: to ?? this.to,
            total: total ?? this.total,
        );

    factory ReviewResponse.fromRawJson(String str) => ReviewResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ReviewData>.from(json["data"]!.map((x) => ReviewData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class ReviewData {
    int? id;
    int? userId;
    int? serviceId;
    String? message;
    double? rating;
    DateTime? createdAt;
    DateTime? updatedAt;
    Service? service;
    User? user;

    ReviewData({
        this.id,
        this.userId,
        this.serviceId,
        this.message,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.service,
        this.user,
    });

    ReviewData copyWith({
        int? id,
        int? userId,
        int? serviceId,
        String? message,
        double? rating,
        DateTime? createdAt,
        DateTime? updatedAt,
        Service? service,
        User? user,
    }) => 
        ReviewData(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            serviceId: serviceId ?? this.serviceId,
            message: message ?? this.message,
            rating: rating ?? this.rating,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            service: service ?? this.service,
            user: user ?? this.user,
        );

    factory ReviewData.fromRawJson(String str) => ReviewData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        message: json["message"],
        rating: json["rating"]?.toDouble(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
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
        "service": service?.toJson(),
        "user": user?.toJson(),
    };
}

class Service {
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
    dynamic images;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? distance;
    double? totalRatingAverage;

    Service({
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
    });

    Service copyWith({
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
        dynamic images,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? distance,
        double? totalRatingAverage,
    }) => 
        Service(
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
        );

    factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Service.fromJson(Map<String, dynamic> json) => Service(
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
        images: json["images"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        distance: json["distance"],
        totalRatingAverage: json["total_rating_average"]?.toDouble(),
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
        "images": images,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "distance": distance,
        "total_rating_average": totalRatingAverage,
    };
}

class User {
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
    String? balance;

    User({
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
        this.balance,
    });

    User copyWith({
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
        String? balance,
    }) => 
        User(
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
            balance: balance ?? this.balance,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        balance: json["balance"],
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
        "balance": balance,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    Link copyWith({
        String? url,
        String? label,
        bool? active,
    }) => 
        Link(
            url: url ?? this.url,
            label: label ?? this.label,
            active: active ?? this.active,
        );

    factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}






// import 'dart:convert';

// class UserReviewResponse {
//   bool? status;
//   String? message;
//   int? code;
//   ReviewResponse? data;

//   UserReviewResponse({
//     this.status,
//     this.message,
//     this.code,
//     this.data,
//   });

//   UserReviewResponse copyWith({
//     bool? status,
//     String? message,
//     int? code,
//     ReviewResponse? data,
//   }) =>
//       UserReviewResponse(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         code: code ?? this.code,
//         data: data ?? this.data,
//       );

//   factory UserReviewResponse.fromRawJson(String str) =>
//       UserReviewResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory UserReviewResponse.fromJson(Map<String, dynamic> json) =>
//       UserReviewResponse(
//         status: json["status"],
//         message: json["message"],
//         code: json["code"],
//         data:
//             json["data"] == null ? null : ReviewResponse.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "code": code,
//         "data": data?.toJson(),
//       };
// }

// class ReviewResponse {
//   int? currentPage;
//   List<ReviewsData>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   dynamic nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;

//   ReviewResponse({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });

//   ReviewResponse copyWith({
//     int? currentPage,
//     List<ReviewsData>? data,
//     String? firstPageUrl,
//     int? from,
//     int? lastPage,
//     String? lastPageUrl,
//     List<Link>? links,
//     dynamic nextPageUrl,
//     String? path,
//     int? perPage,
//     dynamic prevPageUrl,
//     int? to,
//     int? total,
//   }) =>
//       ReviewResponse(
//         currentPage: currentPage ?? this.currentPage,
//         data: data ?? this.data,
//         firstPageUrl: firstPageUrl ?? this.firstPageUrl,
//         from: from ?? this.from,
//         lastPage: lastPage ?? this.lastPage,
//         lastPageUrl: lastPageUrl ?? this.lastPageUrl,
//         links: links ?? this.links,
//         nextPageUrl: nextPageUrl ?? this.nextPageUrl,
//         path: path ?? this.path,
//         perPage: perPage ?? this.perPage,
//         prevPageUrl: prevPageUrl ?? this.prevPageUrl,
//         to: to ?? this.to,
//         total: total ?? this.total,
//       );

//   factory ReviewResponse.fromRawJson(String str) =>
//       ReviewResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<ReviewsData>.from(
//                 json["data"]!.map((x) => ReviewsData.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }

// class ReviewsData {
//   int? id;
//   int? userId;
//   int? serviceId;
//   String? message;
//   double? rating;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   Service? service;

//   ReviewsData({
//     this.id,
//     this.userId,
//     this.serviceId,
//     this.message,
//     this.rating,
//     this.createdAt,
//     this.updatedAt,
//     this.service,
//   });

//   ReviewsData copyWith({
//     int? id,
//     int? userId,
//     int? serviceId,
//     String? message,
//     double? rating,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     Service? service,
//   }) =>
//       ReviewsData(
//         id: id ?? this.id,
//         userId: userId ?? this.userId,
//         serviceId: serviceId ?? this.serviceId,
//         message: message ?? this.message,
//         rating: rating ?? this.rating,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         service: service ?? this.service,
//       );

//   factory ReviewsData.fromRawJson(String str) =>
//       ReviewsData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ReviewsData.fromJson(Map<String, dynamic> json) => ReviewsData(
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
//         service:
//             json["service"] == null ? null : Service.fromJson(json["service"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "service_id": serviceId,
//         "message": message,
//         "rating": rating,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "service": service?.toJson(),
//       };
// }

// class Service {
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
//   dynamic images;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? distance;

//   Service({
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
//   });

//   Service copyWith({
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
//     dynamic images,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? distance,
//   }) =>
//       Service(
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
//       );

//   factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
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
//         images: json["images"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         distance: json["distance"],
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
//         "images": images,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "distance": distance,
//       };
// }

// class Link {
//   String? url;
//   String? label;
//   bool? active;

//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });

//   Link copyWith({
//     String? url,
//     String? label,
//     bool? active,
//   }) =>
//       Link(
//         url: url ?? this.url,
//         label: label ?? this.label,
//         active: active ?? this.active,
//       );

//   factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }
