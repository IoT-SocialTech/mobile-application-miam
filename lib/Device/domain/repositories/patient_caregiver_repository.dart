import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';
import 'package:miam_flutter/Device/domain/entities/responsePatient.dart';

class PatientCaregiverRepository {
  final String baseUrl = "https://miam-cloud-api.onrender.com/api/v1";

  PatientCaregiverRepository();

  Future<List<ResponsePatient>> getPatientsByCaregiverId(int caregiverId) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/patientCaregivers/caregiver/$caregiverId');
    final token = await getToken(); // Asegúrate de tener una función para obtener el token almacenado.

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Agrega el token al header
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final data = jsonResponse['data'] as List;
      print(data);
      return data.map((patient) => ResponsePatient.fromJson(patient['patient'])).toList();
    } else {
      throw Exception("Failed to fetch patients: ${response.body}");
    }
  }

  // obtener a un paciente por su id
  Future<ResponsePatient> getPatientById(int patientId) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/patients/$patientId');
    final token = await getToken(); // Asegúrate de tener una función para obtener el token almacenado.

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Agrega el token al header
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ResponsePatient.fromJson(jsonResponse['data']);
    } else {
      throw Exception("Failed to fetch patient: ${response.body}");
    }
  }


}
