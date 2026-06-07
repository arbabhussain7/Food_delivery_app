import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/auth/presentations/views/login_screen.dart';
import 'package:food_delivery_app/features/bottomNavBar/presentation/views/bottom_nav_bar.dart';
import 'package:food_delivery_app/features/home/presentation/views/home_screen.dart';
import 'package:food_delivery_app/features/home/presentation/views/items_view_screen.dart';
import 'package:food_delivery_app/features/menu/presetations/views/menu_screen.dart';
import 'package:food_delivery_app/features/orders/presentations/views/orders_screen.dart';
import 'package:food_delivery_app/features/profile/presentations/views/profile_screen.dart';
import 'package:food_delivery_app/features/splash/presentations/views/splash_screen.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/views/track_order_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String bottomNavBarScreen = '/bottomNavBarScreen';
  static const String homeScreen = '/homeScreen';
  static const String ordersScreen = '/ordersScreen';
  static const String trackOrderScreen = '/trackOrderScreen';
  static const String profileScreen = '/profileScreen';
  static const String itemsViewScreen = '/itemsViewScreen';
  static const String menuScreen = '/menuScreen';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      loginScreen: (context) => const LoginScreen(),
      bottomNavBarScreen: (context) => const BottomNavBarScreen(),
      homeScreen: (context) => const HomeScreen(),
      ordersScreen: (context) => const OrdersScreen(),
      trackOrderScreen: (context) => const TrackOrderScreen(),
      profileScreen: (context) => const ProfileScreen(),
      itemsViewScreen: (context) => const ItemsViewScreen(),
      menuScreen: (context) => const MenuScreen(),
    };
  }
}
