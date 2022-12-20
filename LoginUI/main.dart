import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_flite/LoginUI/Screens/login_signup.dart';
import 'package:sq_flite/SQFlite/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginSignup(),
    );
  }
}