import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginpage.dart';

void main() {
  runApp(const PseudoJSON());
}

class PseudoJSON extends StatelessWidget {
  const PseudoJSON({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: const LoginPage(),
    );
  }
}
