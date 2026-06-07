import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';

abstract class TrackOrderState {
  const TrackOrderState();
}

class TrackOrderInitial extends TrackOrderState {
  const TrackOrderInitial();
}

class TrackOrderLoading extends TrackOrderState {
  const TrackOrderLoading();
}

class TrackOrderLoaded extends TrackOrderState {
  final OrderEntity order;
  const TrackOrderLoaded(this.order);
}

class TrackOrderFailure extends TrackOrderState {
  final String message;
  const TrackOrderFailure(this.message);
}
