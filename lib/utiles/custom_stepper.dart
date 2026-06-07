import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';

class CustomStepper extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  const CustomStepper({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final Color circleColor = isCompleted || isActive
        ? secondaryColor
        : const Color(0xFFF0F0F0);

    final Color iconColor = isCompleted || isActive ? whiteColor : Colors.grey;

    final Color titleColor = isActive
        ? secondaryColor
        : isCompleted
        ? blackColor
        : Colors.grey;

    final Color subtitleColor = isCompleted || isActive
        ? blackColor.withOpacity(0.5)
        : Colors.grey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? secondaryColor : const Color(0xFFE0E0E0),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyle.bTextStyle.copyWith(
                    color: subtitleColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
