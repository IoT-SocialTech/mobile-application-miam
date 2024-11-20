import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miam_flutter/account/domain/repositories/auth_repository.dart';
import 'package:miam_flutter/account/domain/entities/account.dart';
import 'package:miam_flutter/account/domain/entities/auth_response.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = "https://miam-cloud-api.onrender.com/api/v1";

  @override
  Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return AuthResponse.fromJson(json);
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  @override
  Future<Account> createAccount({
    required String email,
    required String password,
    required int phoneNumber,
    required int subscription,
    required int role,
    required bool active,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "subscription": subscription,
        "role": role,
        "active": active,
      }),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Account.fromJson(json);
    } else {
      throw Exception("Failed to create account: ${response.body}");
    }
  }

  @override
  Future<void> createCaregiver({
    required String name,
    required String lastName,
    required String address,
    required int account,
    required List<int> patientIds,
    required List<int> nursingHomeIds,
  }) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/caregivers');
    final token = await getToken();

    if (token == null) {
      throw Exception("No token found. Please log in again.");
    }

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "lastName": lastName,
        "address": address,
        "account": account,
        "patientIds": patientIds,
        "nursingHomeIds": nursingHomeIds,
      }),
      // im
    );

    if (response.statusCode != 201) {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to create caregiver.';
      throw Exception(error);
    }
  }
  @override
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
    final url = Uri.parse('$baseUrl/miam/cloudApi/patients');
    final token = await getToken();

    if (token == null) {
      throw Exception("No token found. Please log in again.");
    }

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "lastName": lastName,
        "age": age,
        "address": address,
        "birthdate": birthdate,
        "account": accountId,
        "relative": relativeId,
        "caregiverIds": caregiverIds,
      }),
    );

    if (response.statusCode != 201) {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to create patient.';
      throw Exception(error);
    }
  }
}
