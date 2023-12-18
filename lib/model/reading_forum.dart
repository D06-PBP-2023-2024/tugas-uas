// To parse this JSON data, do
//
//     final readingForum = readingForumFromJson(jsonString);

import 'dart:convert';

ReadingForum readingForumFromJson(String str) => ReadingForum.fromJson(json.decode(str));

String readingForumToJson(ReadingForum data) => json.encode(data.toJson());

class ReadingForum {
    List<Discussion> discussions;
    String filterBy;

    ReadingForum({
        required this.discussions,
        required this.filterBy,
    });

    factory ReadingForum.fromJson(Map<String, dynamic> json) => ReadingForum(
        discussions: List<Discussion>.from(json["discussions"].map((x) => Discussion.fromJson(x))),
        filterBy: json["filter_by"],
    );

    Map<String, dynamic> toJson() => {
        "discussions": List<dynamic>.from(discussions.map((x) => x.toJson())),
        "filter_by": filterBy,
    };
}

class Discussion {
    int id;
    String title;
    String content;
    String createdAt;
    String user;
    int numReplies;

    Discussion({
        required this.id,
        required this.title,
        required this.content,
        required this.createdAt,
        required this.user,
        required this.numReplies,
    });

    factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: json["created_at"],
        user: json["user"],
        numReplies: json["num_replies"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_at": createdAt,
        "user": user,
        "num_replies": numReplies,
    };
}
