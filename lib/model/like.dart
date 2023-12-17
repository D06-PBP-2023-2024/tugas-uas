// To parse this JSON data, do
//
//     final like = likeFromJson(jsonString);

import 'dart:convert';

List<Like> likeFromJson(String str) => List<Like>.from(json.decode(str).map((x) => Like.fromJson(x)));

String likeToJson(List<Like> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Like {
    String model;
    int pk;
    Fields fields;

    Like({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    int book;

    Fields({
        required this.user,
        required this.book,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
    };
}
