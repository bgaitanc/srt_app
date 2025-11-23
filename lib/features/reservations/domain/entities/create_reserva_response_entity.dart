import 'package:equatable/equatable.dart';

class CreateReservaResponseEntity extends Equatable {
  final int reservaId;
  final int viajeId;
  final String fechaReserva;
  final double total;
  final ViajeInfo viaje;
  final RutaInfo ruta;

  const CreateReservaResponseEntity({
    required this.reservaId,
    required this.viajeId,
    required this.fechaReserva,
    required this.total,
    required this.viaje,
    required this.ruta,
  });

  @override
  List<Object?> get props => [
        reservaId,
        viajeId,
        fechaReserva,
        total,
        viaje,
        ruta,
      ];
}

class ViajeInfo extends Equatable {
  final double costo;
  final String fechaHoraSalida;
  final String fechaHoraLlegada;

  const ViajeInfo({
    required this.costo,
    required this.fechaHoraSalida,
    required this.fechaHoraLlegada,
  });

  @override
  List<Object?> get props => [costo, fechaHoraSalida, fechaHoraLlegada];
}

class RutaInfo extends Equatable {
  final String locacionOrigen;
  final String locacionDestino;
  final double distanciaKM;
  final String tiempoEstimado;

  const RutaInfo({
    required this.locacionOrigen,
    required this.locacionDestino,
    required this.distanciaKM,
    required this.tiempoEstimado,
  });

  @override
  List<Object?> get props => [
        locacionOrigen,
        locacionDestino,
        distanciaKM,
        tiempoEstimado,
      ];
}
