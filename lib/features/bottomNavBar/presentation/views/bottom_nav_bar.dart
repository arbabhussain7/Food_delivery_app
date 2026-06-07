import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/features/bottomNavBar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:food_delivery_app/features/bottomNavBar/presentation/bloc/bottom_nav_bar_event.dart';
import 'package:food_delivery_app/features/bottomNavBar/presentation/bloc/bottom_nav_bar_state.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationBloc(),
      child: const BottomNavBarView(),
    );
  }
}

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor.withAlpha(300),
      extendBody: true,
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return context
              .read<BottomNavigationBloc>()
              .widgetList[state.selectedIndex];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 9.v, horizontal: 12.h),
                margin: EdgeInsets.symmetric(vertical: 9.v),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.adaptSize),
                    topRight: Radius.circular(20.adaptSize),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(0),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.homeIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 0
                                  ? primaryColor
                                  : blackColor.withOpacity(0.5),
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Home',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 0
                                    ? primaryColor
                                    : blackColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Classes Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(1),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.orderIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 1
                                  ? primaryColor
                                  : blackColor.withOpacity(0.5),
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Menu',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 1
                                    ? primaryColor
                                    : blackColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Material Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(2),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.addCartIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 2
                                  ? primaryColor
                                  : blackColor.withOpacity(0.5),
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Track',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 2
                                    ? primaryColor
                                    : blackColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(3),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.profileIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 3
                                  ? primaryColor
                                  : blackColor.withOpacity(0.5),
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Profile',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 3
                                    ? primaryColor
                                    : blackColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
