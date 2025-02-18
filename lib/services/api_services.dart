import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pseudo_json/models/auth_response.dart';
import 'package:pseudo_json/models/auth_user.dart';

Future<AuthResponse?> loginUser(String username, String password) async {
  final url = Uri.parse('https://dummyjson.com/auth/login');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'password': password,
      'expiresInMins': 30, // optional, defaults to 60
    }),
  );

  if (response.statusCode == 200) {
    return AuthResponse.fromJson(jsonDecode(response.body));
  } else {
    print('Login failed: ${response.body}');
    return null;
  }
}

Future<AuthUser?> getCurrentUser(String accessToken) async {
  final url = Uri.parse('https://dummyjson.com/auth/me');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    return AuthUser.fromJson(jsonDecode(response.body));
  } else {
    print('Failed to fetch user: ${response.body}');
    return null;
  }
}
