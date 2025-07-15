import 'dart:convert';

class CategoriesResponse {
    bool? status;
    int? code;
    List<CategoriesData>? data;

    CategoriesResponse({
        this.status,
        this.code,
        this.data,
    });

    CategoriesResponse copyWith({
        bool? status,
        int? code,
        List<CategoriesData>? data,
    }) => 
        CategoriesResponse(
            status: status ?? this.status,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory CategoriesResponse.fromRawJson(String str) => CategoriesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        status: json["status"],
        code: json["code"],
        data: json["data"] == null ? [] : List<CategoriesData>.from(json["data"]!.map((x) => CategoriesData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CategoriesData {
    int? id;
    String? name;
    String? slug;
    dynamic image;
    String? status;
    dynamic createdAt;
    dynamic updatedAt;

    CategoriesData({
        this.id,
        this.name,
        this.slug,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    CategoriesData copyWith({
        int? id,
        String? name,
        String? slug,
        dynamic image,
        String? status,
        dynamic createdAt,
        dynamic updatedAt,
    }) => 
        CategoriesData(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            image: image ?? this.image,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory CategoriesData.fromRawJson(String str) => CategoriesData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
