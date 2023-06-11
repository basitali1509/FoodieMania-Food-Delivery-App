import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_ui/screens/home_screen.dart';

class SplashScreenController {
  void SplashTime(BuildContext context) {
    Timer(
        const Duration(milliseconds: 4000),
            () =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

}