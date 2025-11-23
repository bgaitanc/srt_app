import 'package:equatable/equatable.dart';

class ReservaDetalleEntity extends Equatable {
  final int viajeId;
  final int capacidad;
  final List<int> asientosReservados;

  const ReservaDetalleEntity({
    required this.viajeId,
    required this.capacidad,
    required this.asientosReservados,
  });

  @override
  List<Object?> get props => [
        viajeId,
        capacidad,
        asientosReservados,
      ];
}
