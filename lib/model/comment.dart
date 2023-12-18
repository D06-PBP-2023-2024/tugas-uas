// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
    List<Book> books;

    Comment({
        required this.books,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
    String comment;

    Book({
        required this.title,
        required this.coverUrl,
        required this.author,
        required this.comment,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        coverUrl: json["cover_url"],
        author: json["author"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "cover_url": coverUrl,
        "author": author,
        "comment": comment,
    };
}