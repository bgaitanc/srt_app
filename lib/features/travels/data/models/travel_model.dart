import '../../domain/entities/travel_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class TravelModel {
  TravelModel._();

  static TravelEntity fromJson(Map<String, dynamic> json) {
    final route = JsonParserHelper.getNestedMap(json, 'route');
    final vehicle = JsonParserHelper.getNestedMap(json, 'vehicle');
    final driver = JsonParserHelper.getNestedMap(json, 'driver');

    return TravelEntity(
      travelId: JsonParserHelper.getValueOrDefault(json, 'travelId', ''),
      price: JsonParserHelper.parseDouble(json['price']),
      departureDate: JsonParserHelper.getValueOrDefault(
        json,
        'departureDate',
        '',
      ),
      arrivalDate: JsonParserHelper.getValueOrDefault(
        json,
        'arrivalDate',
        '',
      ),
      status: JsonParserHelper.getValueOrDefault(json, 'status', ''),
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
      distanceInKm: JsonParserHelper.parseDouble(route['distanceInKm']),
      estimatedTime: JsonParserHelper.getValueOrDefault(
        route,
        'estimatedTime',
        '',
      ),
      registrationPlate: JsonParserHelper.getValueOrDefault(vehicle, 'registrationPlate', ''),
      model: JsonParserHelper.getValueOrDefault(vehicle, 'model', ''),
      capacity: JsonParserHelper.getValueOrDefault(vehicle, 'capacity', 0),
      driverName: JsonParserHelper.getValueOrDefault(
        driver,
        'name',
        '',
      ),
      driverSurname: JsonParserHelper.getValueOrDefault(
        driver,
        'surname',
        '',
      ),
    );
  }
}
