import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _keyToken = 'auth_token';
  static const _keyRole = 'user_role';
  static const _keyUserName = 'user_name';
  static const _keyUserEmail = 'user_email';

  // Fake login API
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "consumer@test.com" && password == "123456") {
      await _saveAuth(
        token: "token-consumer",
        role: "consumer",
        name: "Consumer User",
        email: email,
      );
      return true;
    }

    if (email == "sales@test.com" && password == "123456") {
      await _saveAuth(
        token: "token-sales",
        role: "sales",
        name: "Sales Manager",
        email: email,
      );
      return true;
    }

    return false;
  }

  Future<void> _saveAuth({
    required String token,
    required String role,
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyRole, role);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRole);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyRole);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserEmail);
  }
}
