class ApiEndpoints {  
  // Auth endpoints
  static const String login = '/authentication/login';
  static const String refreshToken = '/authentication/refresh-token';
  static const String register = '/users/register';
  static const String userInfo = '/users/info';
  static const String updateProfile = '/users/profile';
  
  // Reservation endpoints
  static const String reservationsByUser = '/reservations/user';
  static const String createReservation = '/reservations/create';
  static const String reservationDetail = '/reservations/detail';

  // Travels endpoints
  static const String travels = '/travels/all';
  static const String createTravel = '/travels/create';

  // Driver endpoints
  static const String driverTripsAssigned = '/drivertrips/assigned';
  static const String validateTicket = '/reservations/validate';
  static String completeTripById(String travelId) => '/drivertrips/$travelId/complete';
}
