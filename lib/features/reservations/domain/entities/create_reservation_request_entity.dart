import 'package:equatable/equatable.dart';

class CreateReservationRequestEntity extends Equatable {
  final String travelId;
  final List<int> seats;
  final String userId;

  const CreateReservationRequestEntity({
    required this.travelId,
    required this.seats,
    required this.userId,
  });

  @override
  List<Object?> get props => [travelId, seats, userId];
}
