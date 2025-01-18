class ResponseTemperature {
  final double temperature;
  final DateTime date;
  final String status;

  ResponseTemperature({
    required this.temperature,
    required this.date,
    required this.status,
  });

  factory ResponseTemperature.fromJson(Map<String, dynamic> json) {
    return ResponseTemperature(
      temperature: json['temperature'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}
