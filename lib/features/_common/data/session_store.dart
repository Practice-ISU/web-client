import 'package:shared_preferences/shared_preferences.dart';

class SessionStore {
  static const String tokenKey = 'accessToken';

  SessionStore._();

  static final SessionStore _instance = SessionStore._();

  static ensureInitialized() async {
    await _instance._ensureLoadPreferences();
  }

  static SessionStore get instance => _instance;

  String? _token;

  get isLoggedIn async {
    await _ensureLoadPreferences();

    return _token?.isNotEmpty ?? false;
  }

  get accessToken async {
    await _ensureLoadPreferences();

    return _token;
  }

  Future<bool> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(tokenKey, token);
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Future<void> _ensureLoadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);

    if (token != null) {
      _token = token;
    }
  }
}
