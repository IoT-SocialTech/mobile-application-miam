// lib/application/use_cases/login_use_case.dart
import 'package:miam_flutter/account/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<void> execute(String email, String password) async {
    await authRepository.login(email, password);
  }
}