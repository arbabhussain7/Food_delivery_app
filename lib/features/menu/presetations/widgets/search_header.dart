import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final ValueChanged<String> onChanged;

  const SearchHeader({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onClose,
          child: const Icon(
            Icons.arrow_back_rounded,
            color: blackColor,
            size: 24,
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Container(
            height: 40.v,
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            decoration: BoxDecoration(
              color: greyColor.withAlpha(30),
              borderRadius: BorderRadius.circular(20.adaptSize),
            ),
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: onChanged,
              style: AppTextStyle.fTextStyle.copyWith(color: blackColor),
              decoration: InputDecoration(
                hintText: 'Search items, restaurants...',
                hintStyle: AppTextStyle.fTextStyle.copyWith(color: greyColor),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10.v),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.h),
        // Clear button
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return GestureDetector(
              onTap: () {
                controller.clear();
                onChanged('');
              },
              child: const Icon(
                Icons.close_rounded,
                color: greyColor,
                size: 20,
              ),
            );
          },
        ),
      ],
    );
  }
}
