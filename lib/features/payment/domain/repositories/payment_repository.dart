import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/payment/domain/entities/payment_intent_entity.dart';

abstract interface class PaymentRepository {
  Future<Either<Failure, PaymentIntentEntity>> createPaymentIntent({
    required int amountInCents,
    required String currency,
  });
}
