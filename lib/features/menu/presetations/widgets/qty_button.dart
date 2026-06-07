import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';

class QtyButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const QtyButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: whiteColor, size: 14.adaptSize),
      ),
    );
  }
}
