class User {
  final String id; 
  final String username;
  final String email;
  final String? password;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(), // Ensure ID is treated as string
      username: json['username'],
      email: json['email'],
    );
  }
}
