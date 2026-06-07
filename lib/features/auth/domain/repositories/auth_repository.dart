import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
