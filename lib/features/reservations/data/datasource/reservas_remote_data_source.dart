import 'package:dio/dio.dart';
import 'package:srt_app/core/constants/api_endpoints.dart';
import '../../../../core/infrastructure/network/remote_data_source_base.dart';
import '../../domain/entities/reserva_info_entity.dart';
import '../../domain/entities/create_reserva_request_entity.dart';
import '../../domain/entities/create_reserva_response_entity.dart';
import '../models/reserva_info_model.dart';
import '../models/create_reserva_request_model.dart';
import '../models/create_reserva_response_model.dart';
import '../../../../core/utils/response_helper.dart';

class ReservasRemoteDataSource extends RemoteDataSourceBase {
  ReservasRemoteDataSource(super.dio);

  Future<List<ReservaInfoEntity>> getReservasByUser(int userId) async {
    try {
      final response = await dio.get(
        ApiEndpoints.reservasByUser,
        queryParameters: {'userId': userId},
      );

      return ResponseHelper.extractList<ReservaInfoEntity>(
        response,
        'data',
        (json) => ReservaInfoModel.fromJson(json),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }

  Future<CreateReservaResponseEntity> createReserva(
      CreateReservaRequestEntity request) async {
    return await handleRequest<CreateReservaResponseEntity>(
      request: () => dio.post(
        ApiEndpoints.createReserva,
        data: CreateReservaRequestModel.toJson(request),
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
