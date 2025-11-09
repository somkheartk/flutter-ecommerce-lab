import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

/// AuthProvider manages authentication state throughout the app
///
/// This provider handles login, logout, and maintaining user session
/// using ChangeNotifier to notify listeners when state changes
class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  final AuthService _authService = AuthService();

  // Getters to access private variables
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  /// Login method
  ///
  /// Takes email and password, validates them with AuthService
  /// and updates the state accordingly
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Notify UI to show loading state

    try {
      // Call the auth service to perform login
      final user = await _authService.login(email, password);
      _user = user;

      // Save login state to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);
      await prefs.setString('userName', user.name);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Logout method
  ///
  /// Clears user data and session information
  Future<void> logout() async {
    _user = null;

    // Clear saved login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  /// Check if user is already logged in (when app starts)
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final email = prefs.getString('userEmail') ?? '';
      final name = prefs.getString('userName') ?? '';
      _user = User(email: email, name: name);
      notifyListeners();
    }
  }
}
