import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';
import 'package:food_delivery_app/features/home/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;
  const GetProductsUseCase(this._repository);

  Future<Either<Failure, List<ProductEntity>>> call() =>
      _repository.getProducts();
}
