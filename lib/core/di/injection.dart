import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:srt_app/core/infrastructure/network/http_response_interceptor.dart';
import 'package:srt_app/core/infrastructure/network/token_interceptor.dart';
import 'package:srt_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:srt_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:srt_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:srt_app/features/auth/domain/usecases/login_user.dart';
import 'package:srt_app/features/auth/domain/usecases/register_user.dart';
import 'package:srt_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:srt_app/features/auth/domain/usecases/update_user_profile.dart';
import 'package:srt_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:srt_app/features/profile/presentation/bloc/user_info_bloc.dart';
import 'package:srt_app/features/reservations/data/datasource/reservations_remote_data_source.dart';
import 'package:srt_app/features/reservations/data/repositories/reservas_repository_impl.dart';
import 'package:srt_app/features/reservations/domain/repositories/reservas_repository.dart';
import 'package:srt_app/features/reservations/domain/usecases/get_reservas_by_user.dart';
import 'package:srt_app/features/reservations/domain/usecases/create_reserva.dart';
import 'package:srt_app/features/reservations/presentation/bloc/reservation_bloc.dart';
import 'package:srt_app/features/travels/data/datasource/travels_remote_data_source.dart';
import 'package:srt_app/features/travels/data/repositories/travels_repository_impl.dart';
import 'package:srt_app/features/travels/domain/repositories/travels_repository.dart';
import 'package:srt_app/features/travels/domain/usecases/get_travels.dart';
import 'package:srt_app/features/travels/presentation/bloc/travels_bloc.dart';
import 'package:srt_app/core/theme/bloc/theme_bloc.dart';
import 'package:srt_app/features/driver/data/datasources/driver_remote_data_source.dart';
import 'package:srt_app/features/driver/data/repositories/driver_repository_impl.dart';
import 'package:srt_app/features/driver/domain/repositories/driver_repository.dart';
import 'package:srt_app/features/driver/domain/usecases/get_assigned_trips.dart';
import 'package:srt_app/features/driver/domain/usecases/validate_ticket.dart';
import 'package:srt_app/features/driver/domain/usecases/complete_trip.dart';
import 'package:srt_app/features/driver/presentation/bloc/driver_trips_bloc.dart';
import 'package:srt_app/features/driver/presentation/bloc/ticket_scanner_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio Client
  final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080/api';
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  //dio.interceptors.add(QueuedInterceptor());

  dio.interceptors.add(HttpResponseInterceptor());
  dio.interceptors.add(TokenInterceptor(dio));
  
  // Add pretty logger for debugging
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  
  //dio.interceptors.add(TokenInterceptor(dio));

  sl.registerLazySingleton(() => dio);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ReservationsRemoteDataSource>(
    () => ReservationsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<TravelsRemoteDataSource>(
    () => TravelsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<DriverRemoteDataSource>(
    () => DriverRemoteDataSource(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ReservasRepository>(
    () => ReservasRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TravelsRepository>(
    () => TravelsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<DriverRepository>(
    () => DriverRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => UpdateUserProfile(sl()));
  sl.registerLazySingleton(() => GetReservationsByUser(sl()));
  sl.registerLazySingleton(() => GetTravels(sl()));
  sl.registerLazySingleton(() => CreateReservation(sl()));
  sl.registerLazySingleton(() => GetAssignedTrips(sl()));
  sl.registerLazySingleton(() => ValidateTicket(sl()));
  sl.registerLazySingleton(() => CompleteTrip(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        getUserInfo: sl(),
      ));
  sl.registerFactory(() => UserInfoBloc(
        getUserInfo: sl(),
        updateUserProfile: sl(),
      ));
  sl.registerFactory(() => ReservationsBloc(
        getReservationsByUser: sl(),
        createReservation: sl(),
      ));
  sl.registerFactory(() => TravelsBloc(sl()));
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => DriverTripsBloc(
        getAssignedTrips: sl(),
        completeTrip: sl(),
      ));
  sl.registerFactory(() => TicketScannerBloc(validateTicket: sl()));
}
