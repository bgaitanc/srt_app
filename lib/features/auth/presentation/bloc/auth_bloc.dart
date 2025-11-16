import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../../core/utils/session_manager.dart';
import 'package:flutter/foundation.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;

  AuthBloc({required this.loginUser, required this.registerUser}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUser(LoginParams(event.email, event.password));
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => null);
      emit(AuthError(failure?.message ?? 'Unexpected error'));
    } else {
      final user = result.fold((l) => null, (r) => r);
      if (user != null) {
        await SessionManager.saveToken(user.token);
        final saved = await SessionManager.getToken();
        debugPrint('[AUTH] Token guardado en SharedPreferences: $saved');
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Usuario nulo'));
      }
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUser(
      nombre: event.nombre,
      apellido: event.apellido,
      usuario: event.usuario,
      correo: event.correo,
      telefono: event.telefono,
      password: event.password,
    );
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => null);
      emit(AuthError(failure?.message ?? 'Unexpected error'));
    } else {
      final user = result.fold((l) => null, (r) => r);
      if (user != null) {
        await SessionManager.saveToken(user.token);
        final saved = await SessionManager.getToken();
        debugPrint('[AUTH] Token guardado en SharedPreferences: $saved');
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Usuario nulo'));
      }
    }
  }
}
