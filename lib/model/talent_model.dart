class TalentModel {
  int age;
  String uid;
  String city;
  bool gender;
  String name;
  int price;
  num rating;
  String regards;
  String style;
  String text;
  String url;
  TalentModel(
      {required this.age,
      required this.uid,
      required this.city,
      required this.gender,
      required this.name,
      required this.price,
      required this.rating,
      required this.regards,
      required this.style,
      required this.text,
      required this.url});
  factory TalentModel.fromJson(Map<String, dynamic> json) => TalentModel(
      uid: json['uid'],
      age: json['age'],
      city: json['city'],
      gender: json['gender'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      regards: json['regards'],
      style: json['style'].toString(),
      // List<Category>.from(json["style"].map((x) => Category.fromJson(x))),
      text: json['text'],
      url: json['url']);
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
