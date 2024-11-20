// lib/application/use_cases/login_use_case.dart
import 'package:miam_flutter/account/domain/repositories/auth_repository.dart';
import 'package:miam_flutter/account/domain/entities/auth_response.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  // Constructor nombrado
  LoginUseCase({required this.authRepository});

  Future<AuthResponse> execute(String email, String password) async {
    return await authRepository.login(email, password);
  }
}