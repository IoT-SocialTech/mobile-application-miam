// lib/configuration/api_config.dart

class ApiConfig {
  static const String baseUrl = 'https://api.example.com'; // URL base de la API
  static const String apiVersion = '/v1'; // (Opcional) Versión de la API

  // Endpoints específicos
  static const String alertsEndpoint = '$baseUrl$apiVersion/alerts';
  static const String loginEndpoint = '$baseUrl$apiVersion/login';
  static const String userEndpoint = '$baseUrl$apiVersion/user';

// Otros headers o configuraciones pueden ir aquí
}
