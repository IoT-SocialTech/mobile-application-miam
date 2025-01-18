import 'package:miam_flutter/account/domain/repositories/auth_repository.dart';
import 'package:miam_flutter/account/domain/entities/account.dart';
class CreateAccountUseCase {
  final AuthRepository authRepository;

  CreateAccountUseCase({required this.authRepository});

  Future<Account> call({
    required String email,
    required String password,
    required int phoneNumber,
    required int subscription,
    required int role,
    required bool active,
  }) async {
    return await authRepository.createAccount(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      subscription: subscription,
      role: role,
      active: active,
    );
  }

  Future<void> createCaregiver({
    required String name,
    required String lastName,
    required String address,
    required int account,
    required List<int> patientIds,
    required List<int> nursingHomeIds,
  }) async {
    return await authRepository.createCaregiver(
      name: name,
      lastName: lastName,
      address: address,
      account: account,
      patientIds: patientIds,
      nursingHomeIds: nursingHomeIds,
    );
  }

  Future<void> createPatient({
    required String name,
    required String lastName,
    required int age,
    required String address,
    required String birthdate,
    required int accountId,
    required int relativeId,
    required List<int> caregiverIds,
  }) async {
    return await authRepository.createPatient(
      name: name,
      lastName: lastName,
      age: age,
      address: address,
      birthdate: birthdate,
      accountId: accountId,
      relativeId: relativeId,
      caregiverIds: caregiverIds,
    );
  }
}
