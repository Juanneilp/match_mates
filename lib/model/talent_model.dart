class TalentModel {
  String name;
  int price;
  num rating;
  String regards;
  String style;
  String url;
  TalentModel(
      {required this.name,
      required this.price,
      required this.rating,
      required this.regards,
      required this.style,
      required this.url});
  factory TalentModel.fromJson(Map<String, dynamic> json) => TalentModel(
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      regards: json['regards'],
      style: json['style'].toString(),
      // List<Category>.from(json["style"].map((x) => Category.fromJson(x))),
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
