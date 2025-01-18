import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';
import 'package:miam_flutter/Notification/domain/entities/responseMedication.dart';

class MedicationPatientRepository {
  final String baseUrl = "https://miam-cloud-api.onrender.com/api/v1";

  MedicationPatientRepository();

  // Método para crear un nuevo medicamento
  Future<void> createMedicationSchedule({
    required String medicationName,
    required int dose,
    required String hour,
    required bool taken,
    required int patientId,
    required int caregiverId,
  }) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/medicationSchedules');
    final token = await getToken();
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "medicationName": medicationName,
        "dose": dose,
        "hour": hour,
        "taken": taken,
        "patientId": patientId,
        "caregiverId": caregiverId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to create medication schedule: ${response.body}");
    }
  }

  // Método para obtener los medicamentos de un cuidador
  Future<List<ResponseMedication>> getMedicationsByCaregiverId(int caregiverId) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/medicationSchedules/caregiver/$caregiverId');
    final token = await getToken();
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<ResponseMedication> medications = (jsonData['data'] as List)
          .map((item) => ResponseMedication.fromJson(item))
          .toList();
      return medications;
    } else {
      throw Exception("Failed to fetch medications: ${response.body}");
    }
  }

  // Método para eliminar un medicamento
  Future<void> deleteMedicationbyId(int medicationId) async {
    final url = Uri.parse('$baseUrl/miam/cloudApi/medicationSchedules/$medicationId');
    final token = await getToken();
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to delete medication schedule: ${response.body}");
    }
  }
}