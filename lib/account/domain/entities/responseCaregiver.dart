// lib/account/domain/entities/caregiver.dart
import 'package:miam_flutter/account/domain/entities/account.dart';

class ResponseCaregiver {
  final int id;
  final String name;
  final String address;


  ResponseCaregiver({
    required this.id,
    required this.name,
    required this.address,
  });

  factory ResponseCaregiver.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ResponseCaregiver(
      id: data['id'],
      name: data['name'],
      address: data['address'],
    );
  }
}
