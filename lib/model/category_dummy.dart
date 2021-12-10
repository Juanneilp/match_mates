class Category {
  String name;
  String color;
  Category({required this.name, required this.color});
}

var categoryList = [
  //2 first digit in color are opacity just use FF for full color, and the rest 6 digit are hex number
  Category(name: "GAMING", color: "FFFFC0CB"),
  Category(name: "FILM", color: "FF00FFFF")
];
