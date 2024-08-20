import 'package:unit_testing_scenarios/models/secure_storage.dart';

import 'auth_api_client.dart';

class AuthService {
  final AuthApiClient apiClient;
  final SecureStorage secureStorage;

  AuthService({required this.apiClient, required this.secureStorage});

  Future<void> login(String username, String password) async {
    final token = await apiClient.login(username, password);
    await secureStorage.saveToken(token);
  }

  Future<void> logout() async {
    final token = await secureStorage.getToken();
    if (token != null) {
      await apiClient.logout(token);
      await secureStorage.deleteToken();
    } else {
      throw Exception("No token found");
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await secureStorage.getToken();
    return token != null;
  }
}
