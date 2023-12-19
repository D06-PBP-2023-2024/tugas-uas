// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  int? id;
  String? title;
  String? author;
  String? coverUrl;
  int? downloadCount;
  String? content;
  List<Tag>? tags;
  List<Like>? likes;
  List<Comment>? comments;
  List<int>? readingList;

  Book({
    this.id,
    this.title,
    this.author,
    this.coverUrl,
    this.downloadCount,
    this.content,
    this.tags,
    this.likes,
    this.comments,
    this.readingList,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        coverUrl: json["cover_url"],
        downloadCount: json["download_count"],
        content: json["content"],
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        likes: json["likes"] == null
            ? []
            : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        readingList: json["reading_list"] == null
            ? []
            : List<int>.from(json["reading_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "cover_url": coverUrl,
        "download_count": downloadCount,
        "content": content,
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "likes": likes == null
            ? []
            : List<dynamic>.from(likes!.map((x) => x.toJson())),
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "reading_list": readingList == null
            ? []
            : List<dynamic>.from(readingList!.map((x) => x)),
      };
}

class Comment {
  int? id;
  String? user;
  String? comment;

  Comment({
    this.id,
    this.user,
    this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        user: json["user"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "comment": comment,
      };
}

class Like {
  int? id;
  String? user;

  Like({
    this.id,
    this.user,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
      };
}

class Tag {
  int? id;
  String? subject;

  Tag({
    this.id,
    this.subject,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
      };
}
