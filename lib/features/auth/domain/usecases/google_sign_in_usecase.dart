import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/auth/domain/entities/user_entity.dart';
import 'package:food_delivery_app/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository _repository;
  const GoogleSignInUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() => _repository.signInWithGoogle();
}
