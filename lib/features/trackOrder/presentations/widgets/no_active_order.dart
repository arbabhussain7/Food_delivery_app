import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';

class NoActiveOrderScreen extends StatelessWidget {
  const NoActiveOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.delivery_dining_rounded,
                  size: 80,
                  color: greyColor,
                ),
                SizedBox(height: 20.v),
                Text(
                  'No Active Orders',
                  style: AppTextStyle.bTextStyle.copyWith(color: blackColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.v),
                Text(
                  'Place an order and your delivery will be tracked here.',
                  style: AppTextStyle.fTextStyle.copyWith(color: greyColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 28.v),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.menuScreen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.h,
                      vertical: 14.v,
                    ),
                  ),
                  child: Text(
                    'Browse Menu',
                    style: AppTextStyle.eTextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
