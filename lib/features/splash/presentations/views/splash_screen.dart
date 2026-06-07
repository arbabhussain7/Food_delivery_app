import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:food_delivery_app/init_dependencies.dart';
import 'package:food_delivery_app/utiles/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Fire the auth check the moment the bloc is created.
      create: (_) =>
          getIt<AuthBloc>()..add(const CheckAuthStatusRequested()),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Already logged in — skip login, go straight to home.
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.bottomNavBarScreen,
            (_) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.splashImg),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.fastfood_outlined,
                    size: 80,
                    color: transparentColor,
                  ),

                  Text(
                    textAlign: TextAlign.center,
                    "Delicious Moments, Delivered to Your Doorstep!",
                    style: AppTextStyle.bTextStyle.copyWith(color: whiteColor),
                  ),

                  // Show a spinner while checking auth, button once we know
                  // the user is not logged in.
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state is AuthInitial
                        ? const SizedBox(
                            key: ValueKey('loading'),
                            height: 50,
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : CustomButton(
                            key: const ValueKey('button'),
                            text: "Get Started",
                            width: 250,
                            height: 50,
                            borderRadius: 120,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.loginScreen,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
