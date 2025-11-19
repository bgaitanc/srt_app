import 'package:dartz/dartz.dart';
import 'package:srt_app/core/errors/failures.dart';
import 'package:srt_app/core/utils/safe_call.dart';
import 'package:srt_app/features/home/data/datasource/reservas_remote_data_source.dart';
import '../../domain/entities/reserva_info_entity.dart';
import '../../domain/repositories/reservas_repository.dart';

class ReservasRepositoryImpl implements ReservasRepository {
  final ReservasRemoteDataSource remoteDataSource;

  ReservasRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ReservaInfoEntity>>> getReservasByUser(
    int userId,
  ) async {
    return safeCall(() => remoteDataSource.getReservasByUser(userId));
  }
}
