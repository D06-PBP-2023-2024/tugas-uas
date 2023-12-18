// To parse this JSON data, do
//
//     final like = likeFromJson(jsonString);

import 'dart:convert';

Like likeFromJson(String str) => Like.fromJson(json.decode(str));

String likeToJson(Like data) => json.encode(data.toJson());

class Like {
  bool liked;
  int likesCount;

  Like({
    required this.liked,
    required this.likesCount,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        liked: json["liked"],
        likesCount: json["likes_count"],
      );

  Map<String, dynamic> toJson() => {
        "liked": liked,
        "likes_count": likesCount,
      };
}
