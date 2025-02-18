import 'package:flutter/material.dart';
import 'package:pseudo_json/models/auth_user.dart';

class HomePage extends StatelessWidget {
  // Accept AuthUser as a parameter
  final AuthUser user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P S E U D O  J S O N"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, ${user.firstName} ${user.lastName}!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text('Email: ${user.email}'),
              Text('Username: ${user.username}'),
              Text('Role: ${user.role}'),
              const SizedBox(height: 20),
              user.image.isNotEmpty
                  ? Image.network(user.image)
                  : const Text('No image available'),
            ],
          ),
        ),
      ),
    );
  }
}
