import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.borderRadius = 30,
    this.backgroundColor = primaryColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: textStyle ??
            AppTextStyle.gTextStyle.copyWith(
              color: whiteColor,
            ),
      ),
    );
  }
}