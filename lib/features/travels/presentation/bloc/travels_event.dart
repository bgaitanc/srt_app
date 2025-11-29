import 'package:equatable/equatable.dart';

abstract class TravelsEvent extends Equatable {
  const TravelsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTravels extends TravelsEvent {
  const FetchTravels();
}
