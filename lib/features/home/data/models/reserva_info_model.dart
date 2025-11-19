import '../../domain/entities/reserva_info_entity.dart';
import '../../../utils/data/json_parser_helper.dart';

class ReservaInfoModel {
  ReservaInfoModel._();

  static ReservaInfoEntity fromJson(Map<String, dynamic> json) {
    final viaje = JsonParserHelper.getNestedMap(json, 'viaje');
    final ruta = JsonParserHelper.getNestedMap(json, 'ruta');
    final detalle = JsonParserHelper.getValue<List>(json, 'detalle');

    return ReservaInfoEntity(
      reservaId: JsonParserHelper.getValueOrDefault(json, 'reservaId', 0),
      viajeId: JsonParserHelper.getValueOrDefault(json, 'viajeId', 0),
      fechaReserva: JsonParserHelper.parseDateTime(json['fechaReserva']) ??
          DateTime.now(),
      asientos: _parseAsientos(detalle),
      total: JsonParserHelper.parseDouble(json['total']),
      origen: JsonParserHelper.getValueOrDefault(
        ruta,
        'locacionOrigen',
        '',
      ),
      destino: JsonParserHelper.getValueOrDefault(
        ruta,
        'locacionDestino',
        '',
      ),
      fechaSalida: JsonParserHelper.getValueOrDefault(
        viaje,
        'fechaHoraSalida',
        '',
      ),
      fechaLlegada: JsonParserHelper.getValueOrDefault(
        viaje,
        'fechaHoraLlegada',
        '',
      ),
      tipoTransporte: JsonParserHelper.getValueOrDefault(
        viaje,
        'tipoTransporte',
        '',
      ),
      vehiculo: JsonParserHelper.getValueOrDefault(viaje, 'vehiculo', ''),
      modelo: JsonParserHelper.getValueOrDefault(viaje, 'modelo', ''),
      marca: JsonParserHelper.getValueOrDefault(viaje, 'marca', ''),
    );
  }

  static List<int> _parseAsientos(List? detalle) {
    if (detalle == null) return [];
    return JsonParserHelper.getList<int>(
      {'detalle': detalle},
      'detalle',
      (e) => JsonParserHelper.getValueOrDefault(
        e as Map<String, dynamic>?,
        'numeroAsiento',
        0,
      ),
    );
  }
}
