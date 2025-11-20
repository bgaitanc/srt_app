import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/viaje_entity.dart';

abstract class ViajesState extends Equatable {
  const ViajesState();

  @override
  List<Object?> get props => [];
}

class ViajesInitial extends ViajesState {}

class ViajesLoading extends ViajesState {}

class ViajesLoaded extends ViajesState {
  final List<ViajeEntity> viajes;

  const ViajesLoaded(this.viajes);

  @override
  List<Object?> get props => [viajes];
}

class ViajesError extends ViajesState {
  final Failure failure;

  const ViajesError(this.failure);

  @override
  List<Object?> get props => [failure];
}
