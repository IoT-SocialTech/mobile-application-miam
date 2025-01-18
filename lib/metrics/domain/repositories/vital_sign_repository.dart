// lib/metrics/domain/repositories/vital_sign_repository.dart
import 'package:miam_flutter/metrics/domain/entities/vital_sign.dart';

abstract class VitalSignRepository {
  Stream<VitalSign> getVitalSigns();
}
