import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/infrastructure/network/remote_data_source_base.dart';
import '../../../../core/utils/response_helper.dart';
import '../../domain/entities/driver_trip_entity.dart';
import '../../domain/entities/validated_ticket_entity.dart';
import '../models/driver_trip_model.dart';
import '../models/validated_ticket_model.dart';

class DriverRemoteDataSource extends RemoteDataSourceBase {
  DriverRemoteDataSource(super.dio);

  Future<List<DriverTripEntity>> getAssignedTrips() async {
    try {
      final response = await dio.get(ApiEndpoints.driverTripsAssigned);
      return ResponseHelper.extractList<DriverTripEntity>(
        response,
        'data',
        (json) => DriverTripModel.fromJson(json),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // No trips assigned
        return [];
      }
      rethrow;
    }
  }

  Future<ValidatedTicketEntity> validateTicket(String reservationId) async {
    final response = await dio.post(
      ApiEndpoints.validateTicket,
      data: {'reservationId': reservationId},
    );
    
    return ResponseHelper.extractObject<ValidatedTicketEntity>(
      response,
      'data',
      (json) => ValidatedTicketModel.fromJson(json),
    );
  }

  Future<void> completeTrip(String travelId) async {
    await dio.post(ApiEndpoints.completeTripById(travelId));
  }
}
