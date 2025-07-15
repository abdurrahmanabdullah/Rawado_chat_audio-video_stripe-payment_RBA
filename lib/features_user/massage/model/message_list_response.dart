
import 'dart:convert';

class MessageListResponse {
    bool? success;
    int? code;
    String? message;
    List<MessageList>? data;

    MessageListResponse({
        this.success,
        this.code,
        this.message,
        this.data,
    });

    MessageListResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<MessageList>? data,
    }) => 
        MessageListResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory MessageListResponse.fromRawJson(String str) => MessageListResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageListResponse.fromJson(Map<String, dynamic> json) => MessageListResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<MessageList>.from(json["data"]!.map((x) => MessageList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class MessageList {
    User? user;
    LastMessage? lastMessage;

    MessageList({
        this.user,
        this.lastMessage,
    });

    MessageList copyWith({
        User? user,
        LastMessage? lastMessage,
    }) => 
        MessageList(
            user: user ?? this.user,
            lastMessage: lastMessage ?? this.lastMessage,
        );

    factory MessageList.fromRawJson(String str) => MessageList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "last_message": lastMessage?.toJson(),
    };
}

class LastMessage {
    int? id;
    int? senderId;
    int? receiverId;
    String? text;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? conversationId;

    LastMessage({
        this.id,
        this.senderId,
        this.receiverId,
        this.text,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.conversationId,
    });

    LastMessage copyWith({
        int? id,
        int? senderId,
        int? receiverId,
        String? text,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
        int? conversationId,
    }) => 
        LastMessage(
            id: id ?? this.id,
            senderId: senderId ?? this.senderId,
            receiverId: receiverId ?? this.receiverId,
            text: text ?? this.text,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            conversationId: conversationId ?? this.conversationId,
        );

    factory LastMessage.fromRawJson(String str) => LastMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        text: json["text"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        conversationId: json["conversation_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "text": text,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "conversation_id": conversationId,
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
        dynamic phone,
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












// import 'dart:convert';

// class MessageListResponse {
//   bool? success;
//   int? code;
//   String? message;
//   List<MessageList>? data;

//   MessageListResponse({
//     this.success,
//     this.code,
//     this.message,
//     this.data,
//   });

//   MessageListResponse copyWith({
//     bool? success,
//     int? code,
//     String? message,
//     List<MessageList>? data,
//   }) =>
//       MessageListResponse(
//         success: success ?? this.success,
//         code: code ?? this.code,
//         message: message ?? this.message,
//         data: data ?? this.data,
//       );

//   factory MessageListResponse.fromRawJson(String str) =>
//       MessageListResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MessageListResponse.fromJson(Map<String, dynamic> json) =>
//       MessageListResponse(
//         success: json["success"],
//         code: json["code"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<MessageList>.from(
//                 json["data"]!.map((x) => MessageList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "code": code,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class MessageList {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   dynamic address;
//   dynamic longitude;
//   dynamic latitude;
//   dynamic avatar;
//   String? role;
//   String? status;
//   String? isNew;
//   String? available;
//   String? gender;
//   String? balance;

//   MessageList({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.address,
//     this.longitude,
//     this.latitude,
//     this.avatar,
//     this.role,
//     this.status,
//     this.isNew,
//     this.available,
//     this.gender,
//     this.balance,
//   });

//   MessageList copyWith({
//     int? id,
//     String? name,
//     String? email,
//     String? phone,
//     dynamic address,
//     dynamic longitude,
//     dynamic latitude,
//     dynamic avatar,
//     String? role,
//     String? status,
//     String? isNew,
//     String? available,
//     String? gender,
//     String? balance,
//   }) =>
//       MessageList(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         email: email ?? this.email,
//         phone: phone ?? this.phone,
//         address: address ?? this.address,
//         longitude: longitude ?? this.longitude,
//         latitude: latitude ?? this.latitude,
//         avatar: avatar ?? this.avatar,
//         role: role ?? this.role,
//         status: status ?? this.status,
//         isNew: isNew ?? this.isNew,
//         available: available ?? this.available,
//         gender: gender ?? this.gender,
//         balance: balance ?? this.balance,
//       );

//   factory MessageList.fromRawJson(String str) =>
//       MessageList.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
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
//         balance: json["balance"],
//       );

//   Map<String, dynamic> toJson() => {
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
//         "balance": balance,
//       };
// }
