import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';

class CustomizeOption extends StatelessWidget {
  final String label;
  final String? price;
  final bool isSelected;
  final VoidCallback onToggle;

  const CustomizeOption({
    required this.label,
    this.price,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.v, horizontal: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.adaptSize),
        border: Border.all(color: blackColor.withAlpha(300)),
      ),
      child: Row(
        children: [
          Icon(Icons.add_circle_outline, size: 28.h, color: secondaryColor),
          SizedBox(width: 12.h),
          Text(
            label,
            style: AppTextStyle.fTextStyle.copyWith(color: blackColor),
          ),
          const Spacer(),
          if (price != null) ...[
            Text(
              price!,
              style: AppTextStyle.gTextStyle.copyWith(
                color: greyColor.withAlpha(500),
              ),
            ),
            SizedBox(width: 20.h),
          ],
          Checkbox(
            value: isSelected,
            activeColor: secondaryColor,
            onChanged: (_) => onToggle(),
          ),
        ],
      ),
    );
  }
}
