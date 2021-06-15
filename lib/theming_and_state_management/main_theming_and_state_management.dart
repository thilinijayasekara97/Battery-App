// import 'package:batteryapp/theming_and_state_management/presentation/splash/splash_screen.dart';
import 'package:batteryapp/theming_and_state_management/presentation/splash/splash_screen.dart';
import 'package:batteryapp/theming_and_state_management/presentation/theme.dart';
import 'package:flutter/material.dart';
// import 'package:batteryapp/theming_and_state_management/presentation/splash/splash_screen.dart';

class MainThemingAndManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SplashScreen(),
    );
  }
}
