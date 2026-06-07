import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/payment/domain/entities/payment_intent_entity.dart';
import 'package:food_delivery_app/features/payment/domain/repositories/payment_repository.dart';

class CreatePaymentIntentParams {
  final int amountInCents;
  final String currency;
  const CreatePaymentIntentParams({
    required this.amountInCents,
    required this.currency,
  });
}

class CreatePaymentIntentUseCase {
  final PaymentRepository _repository;
  const CreatePaymentIntentUseCase(this._repository);

  Future<Either<Failure, PaymentIntentEntity>> call(
    CreatePaymentIntentParams params,
  ) {
    return _repository.createPaymentIntent(
      amountInCents: params.amountInCents,
      currency: params.currency,
    );
  }
}
