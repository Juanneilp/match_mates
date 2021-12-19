import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.age,
    required this.uid,
    required this.imagelinks,
    required this.friends,
  });

  String name;
  String age;
  String uid;
  String imagelinks;
  List<Friend> friends;

  factory User.fromJson(Map<String, dynamic> json) => User(
        age: json["age"],
        name: json["name"],
        uid: json['uid'],
        imagelinks: json["imagelinks"],
        friends:
            List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
      );
  factory User.fromDb(Map<String, dynamic> json) => User(
      name: json["name"],
      age: json["age"],
      uid: json['uid'],
      imagelinks: json["imagelinks"],
      friends: []);

  Map<String, dynamic> toJson() => {
        'age': age,
        "name": name,
        "uid": uid,
        "imagelinks": imagelinks,
        "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
      };
  Map<String, dynamic> toDb() => {
        "name": name,
        "uid": uid,
        "imagelinks": imagelinks,
      };
}

class Friend {
  Friend({
    required this.nameid,
    required this.tunelid,
    required this.imagelinks,
    required this.name,
  });

  String nameid;
  String tunelid;
  String imagelinks;
  String name;

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        imagelinks: json['imagelinks'],
        name: json['name'],
        nameid: json["nameid"],
        tunelid: json["tunelid"],
      );

  Map<String, dynamic> toJson() => {
        "imagelinks": imagelinks,
        "name": name,
        "nameid": nameid,
        "tunelid": tunelid,
      };
}
