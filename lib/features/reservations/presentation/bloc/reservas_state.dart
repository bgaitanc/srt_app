import '../../domain/entities/reserva_info_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class ReservasState {
  const ReservasState();
}

class ReservasInitial extends ReservasState {
  const ReservasInitial();
}

class ReservasLoading extends ReservasState {
  const ReservasLoading();
}

class ReservasLoaded extends ReservasState {
  final List<ReservaInfoEntity> reservas;
  const ReservasLoaded(this.reservas);
}

class ReservasError extends ReservasState {
  final Failure failure;
  const ReservasError(this.failure);
}

