import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:food_delivery_app/features/auth/domain/entities/user_entity.dart';
import 'package:food_delivery_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await _dataSource.signInWithGoogle();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
