class AuthApiClient {
  Future<String> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == "test" && password == "password") {
      return "dummy_token";
    } else {
      throw Exception("Invalid credentials");
    }
  }

  Future<void> logout(String token) async {
    await Future.delayed(const Duration(seconds: 1));

    if (token != "dummy_token") {
      throw Exception("Invalid token");
    }
  }
}
