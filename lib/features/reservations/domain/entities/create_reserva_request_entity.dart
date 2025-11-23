import 'package:equatable/equatable.dart';

class CreateReservaRequestEntity extends Equatable {
  final int viajeId;
  final List<int> asientos;
  final int usuarioId;

  const CreateReservaRequestEntity({
    required this.viajeId,
    required this.asientos,
    required this.usuarioId,
  });

  @override
  List<Object?> get props => [viajeId, asientos, usuarioId];
}
