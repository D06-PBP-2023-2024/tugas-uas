// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
  String title;
  int author;
  String coverUrl;
  int downloadCount;
  String content;
  List<int> tags;

  Fields({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadCount,
    required this.content,
    required this.tags,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        coverUrl: json["cover_url"],
        downloadCount: json["download_count"],
        content: json["content"],
        tags: List<int>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "cover_url": coverUrl,
        "download_count": downloadCount,
        "content": content,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}
