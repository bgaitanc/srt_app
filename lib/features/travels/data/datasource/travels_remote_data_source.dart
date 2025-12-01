import 'package:dio/dio.dart';
import 'dart:io' show HttpStatus;
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
    try {
      final response = await dio.get(ApiEndpoints.travels);
      return ResponseHelper.extractList<TravelEntity>(
        response,
        'data',
        (json) => TravelModel.fromJson(json),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.notFound) {
        return [];
      }
      rethrow;
    }
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
