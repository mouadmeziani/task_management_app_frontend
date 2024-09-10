import 'dart:convert';

import 'package:http/http.dart' as http;


class StrapiService {
  final String baseUrl = 'http://localhost:1337';
  Future<String?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/local"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identifier': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<String?> registerUser(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/local/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'username': username}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
