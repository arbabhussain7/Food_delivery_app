import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:food_delivery_app/features/auth/presentations/widgets/google_sign_button.dart';
import 'package:food_delivery_app/init_dependencies.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.bottomNavBarScreen);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Stack(
          children: [
            Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    width: double.infinity,
                    AppAssets.authImg,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 20.v),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Back!", style: AppTextStyle.dTextStyle),
                        SizedBox(height: 10.v),

                        Text(
                          "Sign in to continue your culinary journey.",
                          style: AppTextStyle.cTextStyle.copyWith(
                            color: greyColor,
                          ),
                        ),

                        SizedBox(height: 30.v),

                        GoogleSignInButton(isLoading: isLoading),

                        SizedBox(height: 190.v),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: greyColor.withAlpha(100),
                                thickness: 1,
                              ),
                            ),
                            SizedBox(width: 15.h),
                            Text("OR", style: AppTextStyle.cTextStyle),
                            SizedBox(width: 15.h),
                            Expanded(
                              child: Divider(
                                color: greyColor.withAlpha(100),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15.v),

                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: AppTextStyle.cTextStyle.copyWith(
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                "Sign Up",
                                style: AppTextStyle.cTextStyle.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (isLoading)
              AbsorbPointer(
                child: Container(
                  color: Colors.black.withAlpha(100),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: whiteColor,
                      backgroundColor: primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
