import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:srt_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:srt_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:srt_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:srt_app/features/auth/domain/usecases/login_user.dart';
import 'package:srt_app/features/auth/domain/usecases/register_user.dart';
import 'package:srt_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:srt_app/core/config.dart';
import 'package:srt_app/core/utils/session_manager.dart';
import 'package:srt_app/features/home/data/repositories/reservas_repository_impl.dart';
import 'package:srt_app/features/home/data/datasource/reservas_remote_data_source.dart';
import 'package:srt_app/features/home/domain/repositories/reservas_repository.dart';
import 'package:srt_app/features/home/domain/usecases/get_reservas_by_user.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio Client
  final dio = Dio(BaseOptions(baseUrl: Config.baseUrl));
  dio.interceptors.add(
    PrettyDioLogger(
      responseBody: false, // hide response body
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

  // Data Source
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => ReservasRemoteDataSource(sl()));
  sl.registerLazySingleton<ReservasRepository>(() => ReservasRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => GetReservasByUser(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUser: sl(), registerUser: sl()));
}
