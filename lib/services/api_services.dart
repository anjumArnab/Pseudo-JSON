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
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e) {
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
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<List<Product>?> getProductInfo() async {
  try {
    final url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data != null && data['products'] != null) {
        var productsData = data['products'];
        return List<Product>.from(productsData.map((product) => Product.fromJson(product)));
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<List<Product>?> getSearchProduct(String keyword) async {
   try {
    final url = Uri.parse('https://dummyjson.com/products/search?q=$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data != null && data['products'] != null) {
        var productsData = data['products'];
        return List<Product>.from(productsData.map((product) => Product.fromJson(product)));
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<List<Product>?> getSortProducts(String sortBy, String order) async {

  try {
    final url = Uri.parse('https://dummyjson.com/products?sortBy=$sortBy&order=$order');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data != null && data['products'] != null) {
        var productsData = data['products'];
        return List<Product>.from(productsData.map((product) => Product.fromJson(product)));
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}