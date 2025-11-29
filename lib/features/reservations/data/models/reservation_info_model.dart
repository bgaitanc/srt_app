import '../../domain/entities/reservation_info_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class ReservationInfoModel {
  ReservationInfoModel._();

  static ReservationInfoEntity fromJson(Map<String, dynamic> json) {
    final travel = JsonParserHelper.getNestedMap(json, 'travel');
    final route = JsonParserHelper.getNestedMap(json, 'route');
    final details = JsonParserHelper.getValue<List>(json, 'details');

    return ReservationInfoEntity(
      reservationId: JsonParserHelper.getValueOrDefault(json, 'reservationId', 0),
      travelId: JsonParserHelper.getValueOrDefault(json, 'travelId', 0),
      reservationDate: JsonParserHelper.parseDateTime(json['reservationDate']) ??
          DateTime.now(),
      seats: _parseSeats(details),
      total: JsonParserHelper.parseDouble(json['total']),
      originDestination: JsonParserHelper.getValueOrDefault(
        route,
        'originDestination',
        '',
      ),
      finalDestination: JsonParserHelper.getValueOrDefault(
        route,
        'finalDestination',
        '',
      ),
      departureDate: JsonParserHelper.getValueOrDefault(
        travel,
        'departureDate',
        '',
      ),
      arrivalDate: JsonParserHelper.getValueOrDefault(
        travel,
        'arrivalDate',
        '',
      ),
      vehicleType: JsonParserHelper.getValueOrDefault(
        travel,
        'vehicleType',
        '',
      ),
      vehicle: JsonParserHelper.getValueOrDefault(travel, 'vehicle', ''),
      model: JsonParserHelper.getValueOrDefault(travel, 'model', ''),
      brand: JsonParserHelper.getValueOrDefault(travel, 'brand', ''),
    );
  }

  static List<int> _parseSeats(List<dynamic>? detail) {
    if (detail == null) return [];
    
    return JsonParserHelper.getList<int>(
      {'detail': detail},
      'detail',
      (e) => JsonParserHelper.getValueOrDefault(
        e as Map<String, dynamic>,
        'seatNumber',
        0,
      ),
    );
  }
}
