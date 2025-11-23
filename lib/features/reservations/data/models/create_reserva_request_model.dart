import '../../domain/entities/create_reserva_request_entity.dart';

class CreateReservaRequestModel {
  CreateReservaRequestModel._();

  static Map<String, dynamic> toJson(CreateReservaRequestEntity entity) {
    return {
      'clienteId': entity.usuarioId,
      'viajeId': entity.viajeId,
      'detalle': entity.asientos,
      'fechaReserva': DateTime.now().toIso8601String(),
    };
  }
}
