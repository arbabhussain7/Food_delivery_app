import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/bloc/track_order_bloc.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/widgets/no_active_order.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/widgets/track_order_body.dart';
import 'package:food_delivery_app/init_dependencies.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String?;

    if (orderId == null || orderId.isEmpty) {
      return NoActiveOrderScreen();
    }

    return BlocProvider(
      create: (_) => getIt<TrackOrderBloc>()..add(TrackOrderStarted(orderId)),
      child: const TrackOrderBody(),
    );
  }
}
