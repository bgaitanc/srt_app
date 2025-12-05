import '../../domain/entities/driver_trip_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class DriverTripModel {
  DriverTripModel._();

  static DriverTripEntity fromJson(Map<String, dynamic> json) {
    final vehicle = JsonParserHelper.getNestedMap(json, 'vehicle');
    final route = JsonParserHelper.getNestedMap(json, 'route');
    
    return DriverTripEntity(
      travelId: JsonParserHelper.getValueOrDefault(json, 'travelId', ''),
      status: JsonParserHelper.getValueOrDefault(json, 'status', ''),
      originDestination: JsonParserHelper.getValueOrDefault(route, 'originDestination', ''),
      finalDestination: JsonParserHelper.getValueOrDefault(route, 'finalDestination', ''),
      departureDate: JsonParserHelper.getValueOrDefault(json, 'departureDate', ''),
      arrivalDate: JsonParserHelper.getValueOrDefault(json, 'arrivalDate', ''),
      distanceInKm: JsonParserHelper.parseDouble(route['distanceInKm']),
      vehicleModel: JsonParserHelper.getValueOrDefault(vehicle, 'model', ''),
      registrationPlate: JsonParserHelper.getValueOrDefault(vehicle, 'registrationPlate', ''),
      passengerCount: JsonParserHelper.getValueOrDefault(json, 'passengerCount', 0),
      capacity: JsonParserHelper.getValueOrDefault(vehicle, 'capacity', 0),
    );
  }
}
