import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/auth/presentations/bloc/auth_bloc.dart';

class GoogleSignInButton extends StatelessWidget {
  final bool isLoading;
  const GoogleSignInButton({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () => context.read<AuthBloc>().add(const GoogleSignInRequested()),
      child: AnimatedOpacity(
        opacity: isLoading ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
          decoration: BoxDecoration(
            border: Border.all(color: greyColor.withAlpha(100)),
            borderRadius: BorderRadius.circular(8.adaptSize),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.googleIcon),
              SizedBox(width: 10.h),
              Text("Sign in with Google", style: AppTextStyle.cTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
