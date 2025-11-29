import 'package:equatable/equatable.dart';

class ReservationDetailEntity extends Equatable {
  final int travelId;
  final int capacity;
  final List<int> reservedSeats;

  const ReservationDetailEntity({
    required this.travelId,
    required this.capacity,
    required this.reservedSeats,
  });

  @override
  List<Object?> get props => [
        travelId,
        capacity,
        reservedSeats,
      ];
}
