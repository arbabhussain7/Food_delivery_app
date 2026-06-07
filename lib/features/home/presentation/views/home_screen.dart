import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_list.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_events.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_states.dart';
import 'package:food_delivery_app/features/home/presentation/widgets/carousel_sections.dart';
import 'package:food_delivery_app/features/home/presentation/widgets/product_section.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_state.dart';
import 'package:food_delivery_app/init_dependencies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(const ProductsFetchRequested()),
      child: Scaffold(
        backgroundColor: bgColor.withAlpha(500),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                children: [
                  SizedBox(height: 8.v),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.locationsIcon),
                      SizedBox(width: 16.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location',
                            style: AppTextStyle.fTextStyle.copyWith(
                              color: greyColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.v),
                          BlocBuilder<LocationBloc, LocationState>(
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
                                city = '—';
                              }
                              return Text(
                                city,
                                style: AppTextStyle.fTextStyle.copyWith(
                                  color: greyColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.menuScreen),
                        child: SvgPicture.asset(AppAssets.searchIcon),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.v),

                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSection(state: state),

                          SizedBox(height: 22.v),

                          Text(
                            'Categories',
                            style: AppTextStyle.aTextStyle.copyWith(
                              color: blackColor,
                            ),
                          ),
                          SizedBox(height: 22.v),
                          SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              itemCount: listCategories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 60.h,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: greyColor.withAlpha(800),
                                        borderRadius: BorderRadius.circular(
                                          12.adaptSize,
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          listCategories[index],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.v),
                                    Text(
                                      listCategoriesText[index],
                                      style: AppTextStyle.fTextStyle.copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (_, _) => SizedBox(width: 29.h),
                            ),
                          ),

                          SizedBox(height: 22.v),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Near You',
                                style: AppTextStyle.aTextStyle.copyWith(
                                  color: blackColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.menuScreen,
                                  );
                                },

                                child: Text(
                                  'See All',
                                  style: AppTextStyle.eTextStyle.copyWith(
                                    color: primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22.v),

                          ProductsSection(state: state),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
