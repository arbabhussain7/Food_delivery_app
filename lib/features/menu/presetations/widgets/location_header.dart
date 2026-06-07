import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_state.dart';

class LocationHeader extends StatelessWidget {
  final VoidCallback onSearchTap;
  const LocationHeader({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppAssets.locationsIcon),
        SizedBox(width: 12.h),
        Expanded(
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, locState) {
              final String city;
              if (locState is LocationLoaded) {
                city = locState.cityLine;
              } else if (locState is LocationLoading) {
                city = 'Getting location...';
              } else if (locState is LocationPermissionDenied ||
                  locState is LocationServiceDisabled ||
                  locState is LocationError) {
                city = 'Location unavailable';
              } else {
                city = 'Current Location';
              }
              return Text(
                city,
                style: AppTextStyle.iTextStyle.copyWith(color: secondaryColor),
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
        ),
        // Cart badge
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final count = cartState.totalItemCount;
            return GestureDetector(
              onTap: count > 0
                  ? () => Navigator.pushNamed(context, AppRoutes.ordersScreen)
                  : null,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: blackColor,
                    size: 26,
                  ),
                  if (count > 0)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: whiteColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        SizedBox(width: 10.h),
        GestureDetector(
          onTap: onSearchTap,
          child: SvgPicture.asset(AppAssets.searchIcon),
        ),
      ],
    );
  }
}
