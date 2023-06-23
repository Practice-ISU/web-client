import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStore with ChangeNotifier {
  static const String tokenKey = 'accessToken';

  SessionStore._();

  static final SessionStore _instance = SessionStore._();

  static ensureInitialized() async {
    await _instance._ensureLoadPreferences();
  }

  static SessionStore get instance => _instance;

  String? _token;

  Future<bool> get isLoggedIn async {
    await _ensureLoadPreferences();

    return _token?.isNotEmpty ?? false;
  }

  Future<String> get accessToken async {
    await _ensureLoadPreferences();

    return _token ?? '';
  }

  Future<bool> setAccessToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString(tokenKey, token);
    notifyListeners();
    return result;
  }

  Future<bool> deleteAccessToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove(tokenKey);
    notifyListeners();
    return result;
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
