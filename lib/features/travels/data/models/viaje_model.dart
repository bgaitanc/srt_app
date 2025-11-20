import '../../domain/entities/viaje_entity.dart';
import '../../../../core/utils/json_parser_helper.dart';

class ViajeModel {
  ViajeModel._();

  static ViajeEntity fromJson(Map<String, dynamic> json) {
    final ruta = JsonParserHelper.getNestedMap(json, 'ruta');
    final vehiculo = JsonParserHelper.getNestedMap(json, 'vehiculo');
    final conductor = JsonParserHelper.getNestedMap(json, 'conductor');

    return ViajeEntity(
      viajeId: JsonParserHelper.getValueOrDefault(json, 'viajeId', 0),
      costo: JsonParserHelper.parseDouble(json['costo']),
      fechaHoraSalida: JsonParserHelper.getValueOrDefault(
        json,
        'fechaHoraSalida',
        '',
      ),
      fechaHoraLlegada: JsonParserHelper.getValueOrDefault(
        json,
        'fechaHoraLlegada',
        '',
      ),
      estado: JsonParserHelper.getValueOrDefault(json, 'estado', ''),
      locacionOrigen: JsonParserHelper.getValueOrDefault(
        ruta,
        'locacionOrigen',
        '',
      ),
      locacionDestino: JsonParserHelper.getValueOrDefault(
        ruta,
        'locacionDestino',
        '',
      ),
      distanciaKM: JsonParserHelper.parseDouble(ruta['distanciaKM']),
      tiempoEstimado: JsonParserHelper.getValueOrDefault(
        ruta,
        'tiempoEstimado',
        '',
      ),
      placa: JsonParserHelper.getValueOrDefault(vehiculo, 'placa', ''),
      modelo: JsonParserHelper.getValueOrDefault(vehiculo, 'modelo', ''),
      capacidad: JsonParserHelper.getValueOrDefault(vehiculo, 'capacidad', 0),
      conductorNombres: JsonParserHelper.getValueOrDefault(
        conductor,
        'nombres',
        '',
      ),
      conductorApellidos: JsonParserHelper.getValueOrDefault(
        conductor,
        'apellidos',
        '',
      ),
    );
  }
}
