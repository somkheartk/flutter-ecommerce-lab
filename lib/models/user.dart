///
/// This class holds user information like email and name
class User {
  final String email;
  final String name;
  final String? token;

  User({required this.email, required this.name, this.token});

  /// Factory constructor to create a User from JSON
  /// This is useful when receiving data from an API
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String?,
    );
  }

  /// Convert User object to JSON
  /// This is useful when sending data to an API
  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name, 'token': token};
  }
}
