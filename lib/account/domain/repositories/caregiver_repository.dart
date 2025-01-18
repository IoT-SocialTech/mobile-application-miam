import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miam_flutter/account/domain/entities/responseCaregiver.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

class CaregiverRepository {

  final String baseUrl = "https://miam-cloud-api.onrender.com/api/v1";

  CaregiverRepository();

  Future<ResponseCaregiver> getCaregiverByAccountId(int accountId) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/caregivers/account/$accountId');
    final token = await getToken(); // Obtén el token almacenado.

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Incluye el token en los headers.
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ResponseCaregiver.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to fetch caregiver: ${response.body}");
    }
  }
}
