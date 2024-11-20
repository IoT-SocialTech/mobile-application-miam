// lib/domain/repositories/auth_repository.dart
import 'package:miam_flutter/account/domain/entities/account.dart';
import 'package:miam_flutter/account/domain/entities/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<Account> createAccount({
    required String email,
    required String password,
    required int phoneNumber,
    required int subscription,
    required int role,
    required bool active,
  });
  Future<void> createCaregiver({
    required String name,
    required String lastName,
    required String address,
    required int account,
    required List<int> patientIds,
    required List<int> nursingHomeIds,
  });

  Future<void> createPatient({
    required String name,
    required String lastName,
    required int age,
    required String address,
    required String birthdate,
    required int accountId,
    required int relativeId,
    required List<int> caregiverIds,
  });
}