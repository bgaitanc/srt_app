import '../../domain/entities/validated_ticket_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class ValidatedTicketModel {
  ValidatedTicketModel._();

  static ValidatedTicketEntity fromJson(Map<String, dynamic> json) {
    final isValid = JsonParserHelper.getValueOrDefault(json, 'isValid', false);
    
    if (!isValid) {
      return ValidatedTicketEntity.invalid(
        JsonParserHelper.getValueOrDefault(json, 'message', 'Ticket inválido'),
      );
    }

    final seatList = JsonParserHelper.getValue<List>(json, 'seatNumbers') ?? [];
    
    return ValidatedTicketEntity.valid(
      reservationId: JsonParserHelper.getValueOrDefault(json, 'reservationId', ''),
      passengerName: JsonParserHelper.getValueOrDefault(json, 'passengerName', ''),
      passengerSurname: JsonParserHelper.getValueOrDefault(json, 'passengerSurname', ''),
      seatNumbers: seatList.cast<int>(),
      origin: JsonParserHelper.getValueOrDefault(json, 'origin', ''),
      destination: JsonParserHelper.getValueOrDefault(json, 'destination', ''),
      departureDate: JsonParserHelper.getValueOrDefault(json, 'departureDate', ''),
    );
  }
}
