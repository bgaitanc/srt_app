abstract class ReservasEvent {
  const ReservasEvent();
}

class FetchReservas extends ReservasEvent {
  final int userId;
  const FetchReservas(this.userId);
}

