import '../models/user.dart';

/// AuthService handles authentication logic
///
/// In a real app, this would make API calls to a backend server
/// For this lab, we're using mock data for simplicity
class AuthService {
  /// Mock login method
  ///
  /// In a real app, this would make an HTTP POST request to your backend
  /// For now, we accept any email/password combination for learning purposes
  Future<User> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Simple validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (!email.contains('@')) {
      throw Exception('Please enter a valid email');
    }

    if (password.length < 4) {
      throw Exception('Password must be at least 4 characters');
    }

    // Mock successful login - extract name from email
    final name = email.split('@')[0];
    return User(
      email: email,
      name: name.capitalize(),
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  /// Mock registration method
  Future<User> register(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception('All fields are required');
    }

    return User(
      email: email,
      name: name,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}

/// Extension to capitalize strings
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
