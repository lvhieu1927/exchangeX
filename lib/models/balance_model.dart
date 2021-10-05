class Balance{
  final String currency;
  final double balanceValue;

  Balance({required this.currency, required this.balanceValue});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      currency: json['currency'].toString() ,
      balanceValue: double.parse(json['value']),
    );
  }
}