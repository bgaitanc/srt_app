import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:srt_app/core/infrastructure/network/http_response_interceptor.dart';
import 'package:srt_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:srt_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:srt_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:srt_app/features/auth/domain/usecases/login_user.dart';
import 'package:srt_app/features/auth/domain/usecases/register_user.dart';
import 'package:srt_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:srt_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:srt_app/features/profile/presentation/bloc/user_info_bloc.dart';
import 'package:srt_app/features/reservations/data/datasource/reservas_remote_data_source.dart';
import 'package:srt_app/features/reservations/data/repositories/reservas_repository_impl.dart';
import 'package:srt_app/features/reservations/domain/repositories/reservas_repository.dart';
import 'package:srt_app/features/reservations/domain/usecases/get_reservas_by_user.dart';
import 'package:srt_app/features/reservations/domain/usecases/create_reserva.dart';
import 'package:srt_app/features/reservations/presentation/bloc/reservas_bloc.dart';
import 'package:srt_app/features/travels/data/datasource/viajes_remote_data_source.dart';
import 'package:srt_app/features/travels/data/repositories/viajes_repository_impl.dart';
import 'package:srt_app/features/travels/domain/repositories/viajes_repository.dart';
import 'package:srt_app/features/travels/domain/usecases/get_viajes.dart';
import 'package:srt_app/features/travels/presentation/bloc/viajes_bloc.dart';
import 'package:srt_app/core/theme/bloc/theme_bloc.dart';
import 'package:srt_app/core/infrastructure/storage/session_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio Client
  final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080/api';
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  
  // Add HTTP response interceptor
  dio.interceptors.add(HttpResponseInterceptor());
  
  // Add pretty logger for debugging
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true, // Disable if you have large responses
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SessionManager.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );
  sl.registerLazySingleton(() => dio);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ReservasRemoteDataSource>(
    () => ReservasRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ViajesRemoteDataSource>(
    () => ViajesRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ReservasRepository>(
    () => ReservasRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ViajesRepository>(
    () => ViajesRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => GetReservasByUser(sl()));
  sl.registerLazySingleton(() => GetViajes(sl()));
  sl.registerLazySingleton(() => CreateReserva(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        getUserInfo: sl(),
      ));
  sl.registerFactory(() => UserInfoBloc(getUserInfo: sl()));
  sl.registerFactory(() => ReservasBloc(
        getReservasByUser: sl(),
        createReserva: sl(),
      ));
  sl.registerFactory(() => ViajesBloc(sl()));
  sl.registerFactory(() => ThemeBloc());
}
