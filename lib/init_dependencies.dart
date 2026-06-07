import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_bloc.dart';
import 'package:food_delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:food_delivery_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_delivery_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:food_delivery_app/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:food_delivery_app/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:food_delivery_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:food_delivery_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:food_delivery_app/features/home/domain/repositories/product_repository.dart';
import 'package:food_delivery_app/features/home/domain/usecases/get_products_usecase.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_delivery_app/features/menu/presetations/bloc/menu_bloc.dart';
import 'package:food_delivery_app/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:food_delivery_app/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:food_delivery_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:food_delivery_app/features/payment/domain/usecases/create_payment_intent_usecase.dart';
import 'package:food_delivery_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:food_delivery_app/features/trackOrder/data/datasources/order_remote_datasource.dart';
import 'package:food_delivery_app/features/trackOrder/data/repositories/order_repository_impl.dart';
import 'package:food_delivery_app/features/trackOrder/domain/repositories/order_repository.dart';
import 'package:food_delivery_app/features/trackOrder/domain/usecases/create_order_usecase.dart';
import 'package:food_delivery_app/features/trackOrder/domain/usecases/get_order_stream_usecase.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/bloc/track_order_bloc.dart';

final getIt = GetIt.instance;

// Web client ID (client_type: 3) from google-services.json
const _webClientId =
    '285515668411-l43pqunrluuq1fg543uqhlei4ov0hih0.apps.googleusercontent.com';

Future<void> initDependencies() async {
  await _initAuth();
  _initHome();
  _initMenu();
  _initPayment();
  _initTrackOrder();
  _initCart();
  _initLocation();
}

void _initCart() {
  getIt.registerLazySingleton(() => CartBloc());
}

void _initLocation() {
  getIt.registerLazySingleton(() => LocationBloc());
}

Future<void> _initAuth() async {
  await GoogleSignIn.instance.initialize(serverClientId: _webClientId);

  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: getIt()),
  );

  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()));

  getIt.registerFactory(() => GetCurrentUserUseCase(getIt()));
  getIt.registerFactory(() => GoogleSignInUseCase(getIt()));

  getIt.registerFactory(
    () =>
        AuthBloc(getCurrentUserUseCase: getIt(), googleSignInUseCase: getIt()),
  );
}

void _initHome() {
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerFactory<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(firestore: getIt()),
  );

  getIt.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );

  getIt.registerFactory(() => GetProductsUseCase(getIt()));

  getIt.registerFactory(() => HomeBloc(getProductsUseCase: getIt()));
}

void _initMenu() {
  getIt.registerFactory(() => MenuBloc(getProductsUseCase: getIt()));
}

void _initPayment() {
  getIt.registerLazySingleton(() => http.Client());

  getIt.registerFactory<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(
      secretKey: dotenv.env['STRIPE_SECRET_KEY']!,
      client: getIt<http.Client>(),
    ),
  );

  getIt.registerFactory<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt()),
  );

  getIt.registerFactory(() => CreatePaymentIntentUseCase(getIt()));

  getIt.registerFactory(() => PaymentBloc(createPaymentIntentUseCase: getIt()));
}

void _initTrackOrder() {
  getIt.registerFactory<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(firestore: getIt()),
  );

  getIt.registerFactory<OrderRepository>(() => OrderRepositoryImpl(getIt()));

  getIt.registerFactory(() => CreateOrderUseCase(getIt()));
  getIt.registerFactory(() => GetOrderStreamUseCase(getIt()));

  getIt.registerFactory(() => TrackOrderBloc(getOrderStreamUseCase: getIt()));
}
