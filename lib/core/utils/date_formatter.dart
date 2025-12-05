import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
  }

  static String formatDateTimeString(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return formatDateTime(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String formatDateWithDay(DateTime dateTime) {
    return DateFormat('EEEE, dd-MM-yyyy', 'es').format(dateTime);
  }
}
