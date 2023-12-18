// To parse this JSON data, do
//
//     final bookDetail = bookDetailFromJson(jsonString);

import 'dart:convert';

Book bookDetailFromJson(String str) => Book.fromJson(json.decode(str));

String bookDetailToJson(Book data) => json.encode(data.toJson());

class Book {
  int? id;
  Fields? fields;
  int? downloadCount;
  String? content;
  List<Tag>? tags;
  List<Like>? likes;
  List<Comment>? comments;
  List<dynamic>? readingList;

  Book({
    this.id,
    this.fields,
    this.downloadCount,
    this.content,
    this.tags,
    this.likes,
    this.comments,
    this.readingList,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
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
            : List<dynamic>.from(json["reading_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fields": fields?.toJson(),
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

class Fields {
  String? title;
  String? author;
  String? coverUrl;

  Fields({
    this.title,
    this.author,
    this.coverUrl,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        coverUrl: json["cover_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "cover_url": coverUrl,
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
