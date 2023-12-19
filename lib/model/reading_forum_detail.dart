// To parse this JSON data, do
//
//     final readingForumDetail = readingForumDetailFromJson(jsonString);

import 'dart:convert';

ReadingForumDetail readingForumDetailFromJson(String str) => ReadingForumDetail.fromJson(json.decode(str));

String readingForumDetailToJson(ReadingForumDetail data) => json.encode(data.toJson());

class ReadingForumDetail {
    int pk;
    String title;
    String createdAt;
    String content;
    String user;
    List<Reply> replies;

    ReadingForumDetail({
        required this.pk,
        required this.title,
        required this.createdAt,
        required this.content,
        required this.user,
        required this.replies,
    });

    factory ReadingForumDetail.fromJson(Map<String, dynamic> json) => ReadingForumDetail(
        pk: json["pk"],
        title: json["title"],
        createdAt: json["created_at"],
        content: json["content"],
        user: json["user"],
        replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "title": title,
        "created_at": createdAt,
        "content": content,
        "user": [user],
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    };
}

class Reply {
    int pk;
    String createdAt;
    String content;
    String user;

    Reply({
        required this.pk,
        required this.createdAt,
        required this.content,
        required this.user,
    });

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        pk: json["pk"],
        createdAt: json["created_at"],
        content: json["content"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "created_at": createdAt,
        "content": content,
        "user":user,
    };
}


