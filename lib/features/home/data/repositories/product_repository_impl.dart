import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';
import 'package:food_delivery_app/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;

  const ProductRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await _dataSource.getProducts();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
