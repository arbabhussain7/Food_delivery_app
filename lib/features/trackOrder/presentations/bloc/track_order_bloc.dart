import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';
import 'package:food_delivery_app/features/trackOrder/domain/usecases/get_order_stream_usecase.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/bloc/track_order_event.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/bloc/track_order_state.dart';

export 'track_order_event.dart';
export 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  final GetOrderStreamUseCase _getOrderStreamUseCase;

  TrackOrderBloc({required GetOrderStreamUseCase getOrderStreamUseCase})
      : _getOrderStreamUseCase = getOrderStreamUseCase,
        super(const TrackOrderInitial()) {
    on<TrackOrderStarted>(_onTrackOrderStarted);
  }

  Future<void> _onTrackOrderStarted(
    TrackOrderStarted event,
    Emitter<TrackOrderState> emit,
  ) async {
    if (event.orderId.isEmpty) {
      emit(const TrackOrderFailure('No order ID provided'));
      return;
    }

    emit(const TrackOrderLoading());

    await emit.forEach<Either<Failure, OrderEntity>>(
      _getOrderStreamUseCase(event.orderId),
      onData: (result) => result.fold(
        (failure) => TrackOrderFailure(failure.message),
        (order) => TrackOrderLoaded(order),
      ),
      onError: (e, _) => TrackOrderFailure(e.toString()),
    );
  }
}
