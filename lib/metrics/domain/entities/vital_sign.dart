// lib/metrics/domain/entities/vital_sign.dart
class VitalSign {
  final double temperature;
  final int heartRate;
  final DateTime timestamp;

  VitalSign({
    required this.temperature,
    required this.heartRate,
    required this.timestamp,
  });
}
