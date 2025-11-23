import '../../domain/entities/reserva_detalle_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class ReservaDetalleModel {
  ReservaDetalleModel._();

  static ReservaDetalleEntity fromJson(Map<String, dynamic> json) {
    final asientosReservadosJson = json['asientosReservados'] as List<dynamic>?;
    final asientosReservados = asientosReservadosJson
            ?.map((e) => JsonParserHelper.parseInt(e))
            .toList()
            .cast<int>() ??
        <int>[];

    return ReservaDetalleEntity(
      viajeId: JsonParserHelper.getValueOrDefault(json, 'viajeId', 0),
      capacidad: JsonParserHelper.getValueOrDefault(json, 'capacidad', 0),
      asientosReservados: asientosReservados,
    );
  }
}
