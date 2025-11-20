import '../../../../core/infrastructure/network/remote_data_source_base.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/utils/response_helper.dart';
import '../models/viaje_model.dart';
import '../../domain/entities/viaje_entity.dart';

abstract class ViajesRemoteDataSource {
  Future<List<ViajeEntity>> getViajes();
}

class ViajesRemoteDataSourceImpl extends RemoteDataSourceBase
    implements ViajesRemoteDataSource {
  ViajesRemoteDataSourceImpl(super.dio);

  @override
  Future<List<ViajeEntity>> getViajes() async {
    return await handleRequest<List<ViajeEntity>>(
      request: () => dio.get(ApiEndpoints.viajes),
      parser: (response) {
        return ResponseHelper.parseList(
          response,
          (json) => ViajeModel.fromJson(json),
        );
      },
    );
  }
}
