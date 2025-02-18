import 'package:flutter/material.dart';
import 'package:pseudo_json/models/auth_response.dart';
import 'package:pseudo_json/models/auth_user.dart';
import 'package:pseudo_json/models/products.dart';
import 'package:pseudo_json/screens/homepage.dart';
import 'package:pseudo_json/services/api_services.dart';
import 'package:pseudo_json/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<AuthUser?> fetchCurrentUser(String accessToken) async {
    try {
      final user = await getCurrentUser(accessToken);
      return user;
    } catch (e) {
      print('Error fetching current user: $e');
      return null;
    }
  }

  Future<List<Product>?> fetchProductInfo() async {
    try {
      final products = await getProductInfo();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return null;
    }
  }

  Future<void> _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final authResponse = await loginUser(username, password);

      if (authResponse == null) {
        print('Login failed: No response from the server');
        return;
      }

      print('Login successful! Access Token: ${authResponse.accessToken}');

      final user = await fetchCurrentUser(authResponse.accessToken);
      if (user == null) {
        print('User fetch failed');
        return;
      }

      print('User Info: ${user.firstName} ${user.lastName}');

      final products = await fetchProductInfo();
      if (products == null || products.isEmpty) {
        print('No products found');
        return;
      }

      final product = products[0]; // Passing the first product

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: user, product: product),
        ),
      );
    } catch (e) {
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P S E U D O  J S O N"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: _handleLogin,
                text: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
