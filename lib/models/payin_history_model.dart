class PayInHistory{
  final String date;
  final num value;
  final String description;

  PayInHistory({required this.date, required this.value,required this.description});

  factory PayInHistory.fromJson(Map<String, dynamic> json) {
    return PayInHistory(
      date: json['date'].toString(),
      value: num.parse(json['value']),
      description: json['decription'].toString(),
    );
  }
}