import 'dart:convert';

UserProfile userFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.name,
    required this.uid,
    required this.imagelinks,
    required this.talent,
    required this.token,
    required this.bio,
    required this.gender,
    required this.city,
    required this.friends,
    required this.sellers,
  });

  String name;
  String uid;
  String imagelinks;
  bool talent;
  num token;
  String bio;
  String gender;
  String city;
  List<Friend> friends;
  List<Sellers> sellers;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json["name"],
        uid: json['uid'],
        imagelinks: json["imagelinks"],
        talent: json['talent'],
        token: json['token'],
        bio: json['bio'],
        gender: json['gender'],
        city: json['city'],
        friends:
            List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
        sellers:
            List<Sellers>.from(json["sellers"].map((y) => Sellers.fromJson(y))),
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "imagelinks": imagelinks,
        "talent": talent,
        "token": token,
        "bio": bio,
        "gender": gender,
        "city": city,
        "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
        "sellers": List<dynamic>.from(sellers.map((x) => x.toJson())),
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

class Sellers {
  Sellers({
    required this.nameid,
    required this.tunelid,
    required this.imagelinks,
    required this.name,
    required this.price,
  });

  String nameid;
  String tunelid;
  String imagelinks;
  String name;
  int price;

  factory Sellers.fromJson(Map<String, dynamic> json) => Sellers(
        imagelinks: json['imagelinks'],
        name: json['name'],
        nameid: json["nameid"],
        tunelid: json["tunelid"],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        "imagelinks": imagelinks,
        "name": name,
        "nameid": nameid,
        "tunelid": tunelid,
        "price": price,
      };
}
