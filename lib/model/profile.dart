// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  String model;
  int pk;
  Fields fields;

  Profile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? domicile;
  String? username;

  Fields({
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.domicile,
    required this.username,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        domicile: json["domicile"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "domicile": domicile,
        "username": username,
      };
}
