import 'package:batteryapp/theming_and_state_management/main_theming_and_state_management.dart';
import 'package:batteryapp/theming_and_state_management/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainThemingAndManagementApp(),
    );
  }
}
