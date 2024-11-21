import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miam_flutter/metrics/domain/entities/response_temperature.dart';
import 'package:miam_flutter/metrics/domain/entities/response_heart_rate.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

class FeingClientRepository {
  final String baseUrl = "https://miam-cloud-api.onrender.com/api/v1";

  FeingClientRepository();

  Future<ResponseTemperature> getTemperature(int id) async {
    final url = Uri.parse('$baseUrl/miam-cloud-api/metrics/temperature/$id');
    final token = await getToken();

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ResponseTemperature.fromJson(json['data']);
    } else {
      throw Exception("Failed to fetch temperature: ${response.body}");
    }
  }

  Future<ResponseHeartRate> getHeartRate(int id) async {
    final url = Uri.parse('$baseUrl/miam-cloud-api/metrics/heartRate/$id');
    final token = await getToken();

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ResponseHeartRate.fromJson(json['data']);
    } else {
      throw Exception("Failed to fetch heart rate: ${response.body}");
    }
  }
}
