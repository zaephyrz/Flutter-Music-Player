import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthController {
  static const String _baseUrl = 'http://localhost/api'; 

  Future<User?> register(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'register',
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      // First check for HTML errors
      if (response.body.trim().startsWith('<!DOCTYPE')) {
        throw Exception('Server returned HTML error. Check API configuration.');
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        return User.fromJson(responseData['data']['user']);
      } else {
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'login',
          'email': email.toLowerCase().trim(),
          'password': password.trim(),
        }),
      );

      // Check for HTML errors first
      if (response.body.trim().startsWith('<!DOCTYPE')) {
        throw Exception(
          'Server configuration error: Received HTML instead of JSON',
        );
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        return User.fromJson(responseData['data']['user']);
      } else {
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      // In a real app, you would call your logout API endpoint
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      print('Logout error: $e');
      rethrow;
    }
  }
}
