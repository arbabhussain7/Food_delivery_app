import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/core/services/notification_service.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/bloc/track_order_bloc.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/widgets/order_content.dart';

class TrackOrderBody extends StatefulWidget {
  const TrackOrderBody({super.key});

  @override
  State<TrackOrderBody> createState() => TrackOrderBodyState();
}

class TrackOrderBodyState extends State<TrackOrderBody> {
  // Tracks the last status we notified about so we only fire once per change.
  String? _lastNotifiedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocConsumer<TrackOrderBloc, TrackOrderState>(
          listener: (context, state) {
            if (state is! TrackOrderLoaded) return;
            final newStatus = state.order.deliveryStatus;

            // Skip notification on first load; only trigger when status changes.
            if (_lastNotifiedStatus != null &&
                _lastNotifiedStatus != newStatus) {
              NotificationService.showOrderStatusNotification(
                orderId: state.order.id,
                status: newStatus,
              );
            }
            _lastNotifiedStatus = newStatus;
          },
          builder: (context, state) {
            if (state is TrackOrderLoading || state is TrackOrderInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: whiteColor,
                  backgroundColor: primaryColor,
                ),
              );
            }

            if (state is TrackOrderFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyle.eTextStyle.copyWith(color: greyColor),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is TrackOrderLoaded) {
              return OrderContent(order: state.order);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
