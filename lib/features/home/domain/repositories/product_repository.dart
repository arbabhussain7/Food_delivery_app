import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
