import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../../core/utils/session_manager.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;

  AuthBloc({required this.loginUser, required this.registerUser})
      : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _handleAuth(
      () => loginUser(LoginParams(event.email, event.password)),
      emit,
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _handleAuth(
      () => registerUser(event.params),
      emit,
    );
  }

  Future<void> _handleAuth(
    Future<Either<Failure, User>> Function() action,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await action();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) async {
        await SessionManager.saveToken(user.token);
        emit(AuthAuthenticated(user));
      },
    );
  }
}
