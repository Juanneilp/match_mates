import 'package:match_mates/model/user.dart';

class Talent {
  Talent({
    required this.customer,
    required this.echatid,
    required this.name,
    required this.token,
    required this.uid,
    required this.url,
    required this.price,
  });
  List<Friend> customer;
  String echatid;
  String name;
  int token;
  String uid;
  String url;
  int price;

  factory Talent.fromJson(Map<String, dynamic> json) => Talent(
        customer:
            List<Friend>.from(json["customer"].map((x) => Friend.fromJson(x))),
        echatid: json['echatuid'],
        name: json['name'],
        token: json['token'],
        uid: json['uid'],
        url: json['url'],
        price: json['price'],
      );
}
