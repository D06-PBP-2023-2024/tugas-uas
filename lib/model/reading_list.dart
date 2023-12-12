// To parse this JSON data, do
//
//     final readingList = readingListFromJson(jsonString);

import 'dart:convert';

List<ReadingList> readingListFromJson(String str) => List<ReadingList>.from(json.decode(str).map((x) => ReadingList.fromJson(x)));

String readingListToJson(List<ReadingList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadingList {
    String model;
    int pk;
    Fields fields;

    ReadingList({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ReadingList.fromJson(Map<String, dynamic> json) => ReadingList(
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
