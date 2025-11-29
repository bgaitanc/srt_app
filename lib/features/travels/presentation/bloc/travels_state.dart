import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/travel_entity.dart';

abstract class TravelsState extends Equatable {
  const TravelsState();

  @override
  List<Object?> get props => [];
}

class TravelsInitial extends TravelsState {}

class TravelsLoading extends TravelsState {}

class TravelsLoaded extends TravelsState {
  final List<TravelEntity> travels;

  const TravelsLoaded(this.travels);

  @override
  List<Object?> get props => [travels];
}

class TravelsError extends TravelsState {
  final Failure failure;

  const TravelsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
