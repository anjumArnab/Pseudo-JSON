import 'package:flutter/material.dart';
import 'package:pseudo_json/screens/homepage.dart';

void main() {
  runApp(const PseudoJSON());
}

class PseudoJSON extends StatelessWidget {
  const PseudoJSON({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}

