import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:food_delivery_app/features/payment/domain/entities/payment_intent_entity.dart';
import 'package:food_delivery_app/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _dataSource;
  const PaymentRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, PaymentIntentEntity>> createPaymentIntent({
    required int amountInCents,
    required String currency,
  }) async {
    try {
      final model = await _dataSource.createPaymentIntent(
        amountInCents: amountInCents,
        currency: currency,
      );
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
