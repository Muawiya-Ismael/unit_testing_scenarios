class SecureStorage {
  String? _token;

  Future<void> saveToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _token = token;
  }

  Future<String?> getToken() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _token;
  }

  Future<void> deleteToken() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _token = null;
  }
}
