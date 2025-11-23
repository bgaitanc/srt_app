import '../../../../core/infrastructure/network/remote_data_source_base.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/utils/response_helper.dart';
import '../models/viaje_model.dart';
import '../models/reserva_detalle_model.dart';
import '../../domain/entities/viaje_entity.dart';
import '../../domain/entities/reserva_detalle_entity.dart';

abstract class ViajesRemoteDataSource {
  Future<List<ViajeEntity>> getViajes();
  Future<ReservaDetalleEntity> getReservaDetalle(int viajeId);
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

  @override
  Future<ReservaDetalleEntity> getReservaDetalle(int viajeId) async {
    return await handleRequest<ReservaDetalleEntity>(
      request: () => dio.get(
        ApiEndpoints.reservaDetalle,
        queryParameters: {'viajeId': viajeId},
      ),
      parser: (response) {
        return ResponseHelper.parseSingle(
          response,
          (json) => ReservaDetalleModel.fromJson(json),
        );
      },
    );
  }
}
