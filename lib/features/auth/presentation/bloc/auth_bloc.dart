import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/get_user_info.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../../core/infrastructure/storage/session_manager.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final GetUserInfo getUserInfo;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.getUserInfo,
  }) : super(AuthInitial()) {
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
  
    await result.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (user) async {
        await SessionManager.saveToken(user.token);
        await SessionManager.saveRefreshToken(user.refreshToken);
        final userInfoResult = await getUserInfo(NoParams());
        
        await userInfoResult.fold(
          (failure) async {
            await SessionManager.saveUserId(user.userId);
            emit(AuthAuthenticated(user));
          },
          (userInfo) async {
            final localUser = User(
              token: user.token,
              refreshToken: user.refreshToken,
              userId: userInfo.userId,
            );

            await SessionManager.saveUserId(userInfo.userId);
            emit(AuthAuthenticated(localUser));
          },
        );
      },
    );
  }
}
