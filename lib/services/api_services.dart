import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pseudo_json/models/auth_response.dart';
import 'package:pseudo_json/models/auth_user.dart';
import 'package:pseudo_json/models/products.dart';

Future<AuthResponse?> loginUser(String username, String password) async {
  try {
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
      print('Login failed with status code ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error during login: $e');
    return null;
  }
}

Future<AuthUser?> getCurrentUser(String accessToken) async {
  try {
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
  } catch (e) {
    print('Error fetching current user: $e');
    return null;
  }
}

Future<List<Product>?> getProductInfo() async {
  try {
    final url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Response body: ${response.body}'); // Log the full response body

      if (data != null && data['products'] != null) {
        var productsData = data['products'];
        return List<Product>.from(productsData.map((product) => Product.fromJson(product)));
      } else {
        print('No products found in response.');
        return null;
      }
    } else {
      print('Failed to fetch products: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error fetching products: $e');
    return null;
  }
}

