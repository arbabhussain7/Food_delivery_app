import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/auth/domain/entities/user_entity.dart';
import 'package:food_delivery_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:food_delivery_app/features/auth/domain/usecases/google_sign_in_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;

  AuthBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
  })  : _getCurrentUserUseCase = getCurrentUserUseCase,
        _googleSignInUseCase = googleSignInUseCase,
        super(const AuthInitial()) {
    on<CheckAuthStatusRequested>(_onCheckAuthStatus);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getCurrentUserUseCase();
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (user) => user != null
          ? emit(AuthSuccess(user))
          : emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _googleSignInUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
