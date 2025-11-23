import '../../domain/entities/create_reserva_response_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class CreateReservaResponseModel {
  CreateReservaResponseModel._();

  static CreateReservaResponseEntity fromJson(Map<String, dynamic> json) {
    final viajeJson = JsonParserHelper.getNestedMap(json, 'viaje');
    final rutaJson = JsonParserHelper.getNestedMap(json, 'ruta');

    return CreateReservaResponseEntity(
      reservaId: JsonParserHelper.getValueOrDefault(json, 'reservaId', 0),
      viajeId: JsonParserHelper.getValueOrDefault(json, 'viajeId', 0),
      fechaReserva: JsonParserHelper.getValueOrDefault(json, 'fechaReserva', ''),
      total: JsonParserHelper.parseDouble(json['total']),
      viaje: ViajeInfo(
        costo: JsonParserHelper.parseDouble(viajeJson['costo']),
        fechaHoraSalida: JsonParserHelper.getValueOrDefault(
          viajeJson,
          'fechaHoraSalida',
          '',
        ),
        fechaHoraLlegada: JsonParserHelper.getValueOrDefault(
          viajeJson,
          'fechaHoraLlegada',
          '',
        ),
      ),
      ruta: RutaInfo(
        locacionOrigen: JsonParserHelper.getValueOrDefault(
          rutaJson,
          'locacionOrigen',
          '',
        ),
        locacionDestino: JsonParserHelper.getValueOrDefault(
          rutaJson,
          'locacionDestino',
          '',
        ),
        distanciaKM: JsonParserHelper.parseDouble(rutaJson['distanciaKM']),
        tiempoEstimado: JsonParserHelper.getValueOrDefault(
          rutaJson,
          'tiempoEstimado',
          '',
        ),
      ),
    );
  }
}
