// lib/account/domain/entities/account.dart
class Account {
  final int id;
  final String email;
  final String password;
  final int phoneNumber;
  final DateTime createdAt;
  final bool active;

  Account({
    required this.id,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.createdAt,
    required this.active,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['data']['id'],
      email: json['data']['email'],
      password: json['data']['password'],
      phoneNumber: json['data']['phoneNumber'],
      createdAt: DateTime.parse(json['data']['createdAt']),
      active: json['data']['active'],
    );
  }
}
