import '../../domain/entities/reservation_detail_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class ReservationDetailModel {
  ReservationDetailModel._();

  static ReservationDetailEntity fromJson(Map<String, dynamic> json) {
    final reservedSeatsJson = json['reservedSeats'] as List<dynamic>?;
    final reservedSeats = reservedSeatsJson
            ?.map((e) => JsonParserHelper.parseInt(e))
            .toList()
            .cast<int>() ??
        <int>[];

    return ReservationDetailEntity(
      travelId: JsonParserHelper.getValueOrDefault(json, 'travelId', ''),
      capacity: JsonParserHelper.getValueOrDefault(json, 'capacity', 0),
      reservedSeats: reservedSeats,
    );
  }
}
