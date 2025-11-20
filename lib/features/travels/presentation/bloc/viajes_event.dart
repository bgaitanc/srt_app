import 'package:equatable/equatable.dart';

abstract class ViajesEvent extends Equatable {
  const ViajesEvent();

  @override
  List<Object?> get props => [];
}

class FetchViajes extends ViajesEvent {
  const FetchViajes();
}
