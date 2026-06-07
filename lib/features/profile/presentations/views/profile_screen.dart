import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor.withAlpha(500),

      body: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
