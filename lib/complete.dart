import 'package:flutter/material.dart';

class SignUpCompletePage extends StatelessWidget {
  const SignUpCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Sign up Complete!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpCompletePage(),
  ));
}
