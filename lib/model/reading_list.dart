// To parse this JSON data, do
//
//     final readingList = readingListFromJson(jsonString);

import 'dart:convert';

List<ReadingList> readingListFromJson(String str) =>
    List<ReadingList>.from(json.decode(str).map((x) => ReadingList.fromJson(x)));

String readingListToJson(List<ReadingList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadingList {
  List<Book> books;

  ReadingList({
    required this.books,
  });

  factory ReadingList.fromJson(Map<String, dynamic> json) => ReadingList(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Book {
  String title;
  String coverUrl;
  String author;

  Book({
    required this.title,
    required this.coverUrl,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        coverUrl: json["cover_url"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "cover_url": coverUrl,
        "author": author,
      };
}
