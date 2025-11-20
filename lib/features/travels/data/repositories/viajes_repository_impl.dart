import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/viaje_entity.dart';
import '../../domain/repositories/viajes_repository.dart';
import '../datasource/viajes_remote_data_source.dart';

class ViajesRepositoryImpl implements ViajesRepository {
  final ViajesRemoteDataSource remoteDataSource;

  ViajesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ViajeEntity>>> getViajes() async {
    return await safeCall(() => remoteDataSource.getViajes());
  }
}
