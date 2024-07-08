import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return newMethod();
  }

  MaterialApp newMethod() {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 52, 63, 211),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
