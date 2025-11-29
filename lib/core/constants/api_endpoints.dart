class ApiEndpoints {  
  // Auth endpoints
  static const String login = '/authentication/login';
  static const String refreshToken = '/authentication/refresh-token';
  static const String register = '/users/register';
  static const String userInfo = '/users/info';
  
  // Reservation endpoints
  static const String reservationsByUser = '/reservations/user';
  static const String createReservation = '/reservations/create';
  static const String reservationDetail = '/reservations/detail';

  // Travels endpoints
  static const String travels = '/travels/all';
  static const String createTravel = '/travels/create';
}
