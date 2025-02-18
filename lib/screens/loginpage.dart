import 'package:flutter/material.dart';
import 'package:pseudo_json/models/auth_response.dart';
import 'package:pseudo_json/models/auth_user.dart';
import 'package:pseudo_json/screens/homepage.dart';
import 'package:pseudo_json/services/api_services.dart';
import 'package:pseudo_json/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomepageState();
}

class _HomepageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    AuthResponse? authResponse = await loginUser(username, password);

    if (authResponse != null) {
      print('Login successful! Access Token: ${authResponse.accessToken}');
      AuthUser? user = await getCurrentUser(authResponse.accessToken);
      if (user != null) {
        print('User Info: ${user.firstName} ${user.lastName}');
        // Pass user data to HomePage after login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: user), // Pass user here
          ),
        );
      }
    } else {
      print('Login failed');
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
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
