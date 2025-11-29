import '../../domain/entities/create_reservation_response_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class CreateReservaResponseModel {
  CreateReservaResponseModel._();

  static CreateReservationResponseEntity fromJson(Map<String, dynamic> json) {
    final travelJson = JsonParserHelper.getNestedMap(json, 'travel');
    final routeJson = JsonParserHelper.getNestedMap(json, 'route');

    return CreateReservationResponseEntity(
      reservationId: JsonParserHelper.getValueOrDefault(json, 'reservationId', 0),
      travelId: JsonParserHelper.getValueOrDefault(json, 'travelId', 0),
      reservationDate: JsonParserHelper.getValueOrDefault(json, 'reservationDate', ''),
      total: JsonParserHelper.parseDouble(json['total']),
      travel: TravelInfo(
        price: JsonParserHelper.parseDouble(travelJson['price']),
        departureDate: JsonParserHelper.getValueOrDefault(
          travelJson,
          'departureDate',
          '',
        ),
        arrivalDate: JsonParserHelper.getValueOrDefault(
          travelJson,
          'arrivalDate',
          '',
        ),
      ),
      route: RouteInfo(
        originDestination: JsonParserHelper.getValueOrDefault(
          routeJson,
          'originDestination',
          '',
        ),
        finalDestination: JsonParserHelper.getValueOrDefault(
          routeJson,
          'finalDestination',
          '',
        ),
        distanceInKm: JsonParserHelper.parseDouble(routeJson['distanceInKm']),
        estimatedTime: JsonParserHelper.getValueOrDefault(
          routeJson,
          'estimatedTime',
          '',
        ),
      ),
    );
  }
}
