import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/config/routes_observer.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/services/fcm_service.dart';
import 'package:food_delivery_app/core/services/notification_service.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_event.dart';
import 'package:food_delivery_app/firebase_options.dart';
import 'package:food_delivery_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  await FCMService.init();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  await initDependencies();

  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<CartBloc>()),
        BlocProvider.value(
          value: getIt<LocationBloc>()..add(const LocationRequested()),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Food Delivery App',
            theme: ThemeData(
              scaffoldBackgroundColor: whiteColor,
              primaryColor: primaryColor,
              progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: primaryColor,
                circularTrackColor: primaryColor,
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: primaryColor,
                selectionColor: primaryColor,
                selectionHandleColor: primaryColor,
              ),
            ),
            navigatorObservers: [routeObserver],
            initialRoute: AppRoutes.splashScreen,
            routes: AppRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}
