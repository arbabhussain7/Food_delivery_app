import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/features/payment/domain/usecases/create_payment_intent_usecase.dart';
import 'package:food_delivery_app/features/payment/presentation/bloc/payment_event.dart';
import 'package:food_delivery_app/features/payment/presentation/bloc/payment_state.dart';

export 'payment_event.dart';
export 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentIntentUseCase _createPaymentIntentUseCase;

  PaymentBloc({required CreatePaymentIntentUseCase createPaymentIntentUseCase})
      : _createPaymentIntentUseCase = createPaymentIntentUseCase,
        super(const PaymentInitial()) {
    on<PaymentInitiated>(_onPaymentInitiated);
  }

  Future<void> _onPaymentInitiated(
    PaymentInitiated event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());

    final amountInCents = (event.totalAmount * 100).round();

    final result = await _createPaymentIntentUseCase(
      CreatePaymentIntentParams(
        amountInCents: amountInCents,
        currency: 'usd',
      ),
    );

    // Unpack Either without async inside fold
    String? failureMessage;
    String? clientSecret;

    result.fold(
      (failure) => failureMessage = failure.message,
      (intent) => clientSecret = intent.clientSecret,
    );

    if (failureMessage != null) {
      emit(PaymentFailure(failureMessage!));
      return;
    }

    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret!,
          merchantDisplayName: 'Food Delivery',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      emit(const PaymentSuccess());
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        // User dismissed the sheet — go back to idle, no error shown
        emit(const PaymentInitial());
      } else {
        emit(PaymentFailure(e.error.localizedMessage ?? 'Payment failed'));
      }
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
