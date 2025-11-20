import 'package:meta/meta.dart';

@immutable
class ReservaInfoEntity {
  final int reservaId;
  final int viajeId;
  final DateTime fechaReserva;
  final List<int> asientos;
  final double total;
  final String origen;
  final String destino;
  final String fechaSalida;
  final String fechaLlegada;
  final String tipoTransporte;
  final String vehiculo;
  final String modelo;
  final String marca;

  const ReservaInfoEntity({
    required this.reservaId,
    required this.viajeId,
    required this.fechaReserva,
    required this.asientos,
    required this.total,
    required this.origen,
    required this.destino,
    required this.fechaSalida,
    required this.fechaLlegada,
    required this.tipoTransporte,
    required this.vehiculo,
    required this.modelo,
    required this.marca,
  });
}
