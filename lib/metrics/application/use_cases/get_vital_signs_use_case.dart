// lib/metrics/application/use_cases/get_vital_signs_use_case.dart
import 'package:miam_flutter/metrics/domain/entities/vital_sign.dart';
import 'package:miam_flutter/metrics/domain/repositories/vital_sign_repository.dart';

class GetVitalSignsUseCase {
  final VitalSignRepository repository;

  GetVitalSignsUseCase(this.repository);

  Stream<VitalSign> execute() {
    return repository.getVitalSigns();
  }
}
