import '../../../../core/infrastructure/network/remote_data_source_base.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/utils/response_helper.dart';
import '../models/travel_model.dart';
import '../models/reservation_detail_model.dart';
import '../../domain/entities/travel_entity.dart';
import '../../domain/entities/reservation_detail_entity.dart';

abstract class TravelsRemoteDataSource {
  Future<List<TravelEntity>> getTravels();
  Future<ReservationDetailEntity> getReservationDetail(String travelId);
}

class TravelsRemoteDataSourceImpl extends RemoteDataSourceBase
    implements TravelsRemoteDataSource {
  TravelsRemoteDataSourceImpl(super.dio);

  @override
  Future<List<TravelEntity>> getTravels() async {
    return await handleRequest<List<TravelEntity>>(
      request: () => dio.get(ApiEndpoints.travels),
      parser: (response) {
        return ResponseHelper.parseList(
          response,
          (json) => TravelModel.fromJson(json),
        );
      },
    );
  }

  @override
  Future<ReservationDetailEntity> getReservationDetail(String travelId) async {
    return await handleRequest<ReservationDetailEntity>(
      request: () => dio.get(
        ApiEndpoints.reservationDetail,
        queryParameters: {'travelId': travelId},
      ),
      parser: (response) {
        return ResponseHelper.parseSingle(
          response,
          (json) => ReservationDetailModel.fromJson(json),
        );
      },
    );
  }
}
