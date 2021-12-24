class HangoutModel {
  HangoutModel(
      {required this.age,
      required this.city,
      required this.free,
      required this.gender,
      required this.name,
      required this.price,
      required this.rating,
      required this.regards,
      required this.street,
      required this.style,
      required this.text,
      required this.url});

  int age;
  String city;
  String free;
  bool gender;
  String name;
  num price;
  num rating;
  String regards;
  String street;
  String style;
  String text;
  String url;

  factory HangoutModel.fromJson(Map<String, dynamic> json) => HangoutModel(
      age: json['age'],
      city: json['city'],
      free: json['free'],
      gender: json['gender'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      regards: json['regards'],
      street: json['street'],
      style: json['style'].toString(),
      text: json['text'],
      url: json['url']);
}
