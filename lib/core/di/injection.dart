import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:srt_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:srt_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:srt_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:srt_app/features/auth/domain/usecases/login_user.dart';
import 'package:srt_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:srt_app/core/config.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio Client
  final dio = Dio(BaseOptions(baseUrl: Config.baseUrl));
  dio.interceptors.add(PrettyDioLogger());
  sl.registerLazySingleton(() => dio);

  // Data Source
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUser(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUser: sl()));
}
