// lib/metrics/infrastructure/repositories/vital_sign_repository_impl.dart
import 'dart:async';
import 'package:miam_flutter/metrics/domain/entities/vital_sign.dart';
import 'package:miam_flutter/metrics/domain/repositories/vital_sign_repository.dart';

class VitalSignRepositoryImpl implements VitalSignRepository {
  @override
  Stream<VitalSign> getVitalSigns() async* {
    // Simulación de datos de signos vitales en tiempo real
    while (true) {
      await Future.delayed(Duration(seconds: 2)); // Simula el retraso en tiempo real
      final vitalSign = VitalSign(
        temperature: 36.0 + (0.5 - (DateTime.now().second % 2)), // Genera fluctuaciones aleatorias
        heartRate: 75 + (DateTime.now().second % 5),
        timestamp: DateTime.now(),
      );
      yield vitalSign;
    }
  }
}
