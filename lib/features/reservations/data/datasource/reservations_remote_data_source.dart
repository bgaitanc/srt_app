import 'package:dio/dio.dart';
import 'package:srt_app/core/constants/api_endpoints.dart';
import '../../../../core/infrastructure/network/remote_data_source_base.dart';
import '../../domain/entities/reservation_info_entity.dart';
import '../../domain/entities/create_reservation_request_entity.dart';
import '../../domain/entities/create_reservation_response_entity.dart';
import '../models/reservation_info_model.dart';
import '../models/create_reservation_request_model.dart';
import '../models/create_reservation_response_model.dart';
import '../../../../core/utils/response_helper.dart';

class ReservationsRemoteDataSource extends RemoteDataSourceBase {
  ReservationsRemoteDataSource(super.dio);

  Future<List<ReservationInfoEntity>> getReservationsByUser(String userId) async {
    try {
      final response = await dio.get(
        ApiEndpoints.reservationsByUser,
        queryParameters: {'userId': userId},
      );

      return ResponseHelper.extractList<ReservationInfoEntity>(
        response,
        'data',
        (json) => ReservationInfoModel.fromJson(json),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }

  Future<CreateReservationResponseEntity> createReservation(
      CreateReservationRequestEntity request) async {
    return await handleRequest<CreateReservationResponseEntity>(
      request: () => dio.post(
        ApiEndpoints.createReservation,
        data: CreateReservationRequestModel.toJson(request),
      ),
      parser: (response) {
        return ResponseHelper.parseSingle(
          response,
          (json) => CreateReservaResponseModel.fromJson(json),
        );
      },
    );
  }
}
