import 'package:miam_flutter/account/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    // Aquí es donde iría tu lógica de autenticación, como una llamada a un servidor de autenticación o Firebase.
    // Puedes simular un inicio de sesión por ahora:
    await Future.delayed(Duration(seconds: 2)); // Simular tiempo de espera
    if (email != "test@example.com" || password != "password") {
      throw Exception("Invalid email or password");
    }
  }
}