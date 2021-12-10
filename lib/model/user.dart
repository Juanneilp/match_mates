import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.imagelinks,
    required this.friends,
  });

  String name;
  String imagelinks;
  List<Friend> friends;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        imagelinks: json["imagelinks"],
        friends:
            List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imagelinks": imagelinks,
        "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
      };
}

class Friend {
  Friend({
    required this.nameid,
    required this.tunelid,
  });

  String nameid;
  String tunelid;

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        nameid: json["nameid"],
        tunelid: json["tunelid"],
      );

  Map<String, dynamic> toJson() => {
        "nameid": nameid,
        "tunelid": tunelid,
      };
}
