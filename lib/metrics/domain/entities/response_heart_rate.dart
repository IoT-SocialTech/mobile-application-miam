class ResponseHeartRate {
  final int heartRate;
  final DateTime date;
  final String status;

  ResponseHeartRate({
    required this.heartRate,
    required this.date,
    required this.status,
  });

  factory ResponseHeartRate.fromJson(Map<String, dynamic> json) {
    return ResponseHeartRate(
      heartRate: json['heartRate'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}
