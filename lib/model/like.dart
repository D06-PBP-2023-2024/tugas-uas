// To parse this JSON data, do
//
//     final like = likeFromJson(jsonString);

import 'dart:convert';

Like likeFromJson(String str) => Like.fromJson(json.decode(str));

String likeToJson(Like data) => json.encode(data.toJson());

class Like {
    List<Book> books;

    Like({
        required this.books,
    });

    factory Like.fromJson(Map<String, dynamic> json) => Like(
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
