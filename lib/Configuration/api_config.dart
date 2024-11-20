// lib/configuration/api_config.dart

class ApiConfig {
  static const String baseUrl = 'https://miam-cloud-api.onrender.com/api'; // URL base de la API
  static const String apiVersion = '/v1/miam/cloudApi'; // (Opcional) Versión de la API

  // Endpoints específicos
  static const String notificationsEndpoint = '$baseUrl$apiVersion/notifications';
  static const String loginEndpoint = '$baseUrl$apiVersion/login';
  static const String userEndpoint = '$baseUrl$apiVersion/user';

// Otros headers o configuraciones pueden ir aquí
}
