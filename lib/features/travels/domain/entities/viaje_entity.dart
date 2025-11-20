import 'package:equatable/equatable.dart';

class ViajeEntity extends Equatable {
  final int viajeId;
  final double costo;
  final String fechaHoraSalida;
  final String fechaHoraLlegada;
  final String estado;
  
  // Ruta info
  final String locacionOrigen;
  final String locacionDestino;
  final double distanciaKM;
  final String tiempoEstimado;
  
  // Vehiculo info
  final String placa;
  final String modelo;
  final int capacidad;
  
  // Conductor info
  final String conductorNombres;
  final String conductorApellidos;

  const ViajeEntity({
    required this.viajeId,
    required this.costo,
    required this.fechaHoraSalida,
    required this.fechaHoraLlegada,
    required this.estado,
    required this.locacionOrigen,
    required this.locacionDestino,
    required this.distanciaKM,
    required this.tiempoEstimado,
    required this.placa,
    required this.modelo,
    required this.capacidad,
    required this.conductorNombres,
    required this.conductorApellidos,
  });

  @override
  List<Object?> get props => [
        viajeId,
        costo,
        fechaHoraSalida,
        fechaHoraLlegada,
        estado,
        locacionOrigen,
        locacionDestino,
        distanciaKM,
        tiempoEstimado,
        placa,
        modelo,
        capacidad,
        conductorNombres,
        conductorApellidos,
      ];
}
