import 'dart:convert';

class TrainerBookingResponse {
    bool? status;
    String? message;
    int? code;
    List<TrainerBookingData>? data;

    TrainerBookingResponse({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    TrainerBookingResponse copyWith({
        bool? status,
        String? message,
        int? code,
        List<TrainerBookingData>? data,
    }) => 
        TrainerBookingResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory TrainerBookingResponse.fromRawJson(String str) => TrainerBookingResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrainerBookingResponse.fromJson(Map<String, dynamic> json) => TrainerBookingResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? [] : List<TrainerBookingData>.from(json["data"]!.map((x) => TrainerBookingData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TrainerBookingData {
    int? id;
    int? serviceId;
    DateTime? dateFull;
    String? startTime;
    String? endTime;
    String? location;
    String? longitude;
    String? latitude;
    String? trainerConfirm;
    String? customerConfirm;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Booking? booking;
    Service? service;
    List<dynamic>? reschedules;

    TrainerBookingData({
        this.id,
        this.serviceId,
        this.dateFull,
        this.startTime,
        this.endTime,
        this.location,
        this.longitude,
        this.latitude,
        this.trainerConfirm,
        this.customerConfirm,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.booking,
        this.service,
        this.reschedules,
    });

    TrainerBookingData copyWith({
        int? id,
        int? serviceId,
        DateTime? dateFull,
        String? startTime,
        String? endTime,
        String? location,
        String? longitude,
        String? latitude,
        String? trainerConfirm,
        String? customerConfirm,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Booking? booking,
        Service? service,
        List<dynamic>? reschedules,
    }) => 
        TrainerBookingData(
            id: id ?? this.id,
            serviceId: serviceId ?? this.serviceId,
            dateFull: dateFull ?? this.dateFull,
            startTime: startTime ?? this.startTime,
            endTime: endTime ?? this.endTime,
            location: location ?? this.location,
            longitude: longitude ?? this.longitude,
            latitude: latitude ?? this.latitude,
            trainerConfirm: trainerConfirm ?? this.trainerConfirm,
            customerConfirm: customerConfirm ?? this.customerConfirm,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            booking: booking ?? this.booking,
            service: service ?? this.service,
            reschedules: reschedules ?? this.reschedules,
        );

    factory TrainerBookingData.fromRawJson(String str) => TrainerBookingData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrainerBookingData.fromJson(Map<String, dynamic> json) => TrainerBookingData(
        id: json["id"],
        serviceId: json["service_id"],
        dateFull: json["date_full"] == null ? null : DateTime.parse(json["date_full"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        trainerConfirm: json["trainer_confirm"],
        customerConfirm: json["customer_confirm"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
        reschedules: json["reschedules"] == null ? [] : List<dynamic>.from(json["reschedules"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "date_full": "${dateFull!.year.toString().padLeft(4, '0')}-${dateFull!.month.toString().padLeft(2, '0')}-${dateFull!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "trainer_confirm": trainerConfirm,
        "customer_confirm": customerConfirm,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "booking": booking?.toJson(),
        "service": service?.toJson(),
        "reschedules": reschedules == null ? [] : List<dynamic>.from(reschedules!.map((x) => x)),
    };
}
class Booking {
    int? id;
    int? userId;
    int? serviceId;
    int? scheduleId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    List<dynamic>? payments;

    Booking({
        this.id,
        this.userId,
        this.serviceId,
        this.scheduleId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.payments,
    });

    Booking copyWith({
        int? id,
        int? userId,
        int? serviceId,
        int? scheduleId,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        User? user,
        List<dynamic>? payments,
    }) => 
        Booking(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            serviceId: serviceId ?? this.serviceId,
            scheduleId: scheduleId ?? this.scheduleId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
            payments: payments ?? this.payments,
        );

    factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        scheduleId: json["schedule_id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        payments: json["payments"] == null ? [] : List<dynamic>.from(json["payments"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_id": serviceId,
        "schedule_id": scheduleId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x)),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? phone;
    dynamic address;
    dynamic longitude;
    dynamic latitude;
    String? avatar;
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
        String? phone,
        dynamic address,
        dynamic longitude,
        dynamic latitude,
        String? avatar,
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
