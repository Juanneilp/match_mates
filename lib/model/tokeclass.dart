class TokenClass {
  int amount;
  TokenClass({required this.amount});
  factory TokenClass.fromJson(Map<String, dynamic> json) =>
      TokenClass(amount: json['amount']);
}
