// lib/account/domain/entities/auth_response.dart
class AuthResponse {
  final int id;
  final String token;

  AuthResponse({
    required this.id,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return AuthResponse(
      id: data['id'],
      token: data['token'],
    );
  }
}
