import 'package:intl/intl.dart';

class StringUtils {
  static urlDateFormat(DateTime date) {
    final String formattedDate = DateFormat("yyyy-MM-dd").format(date);
    return formattedDate;
  }

  static newsDateFormat(String date) {
    final String formattedDate = DateFormat("E, dd MMM yyyy H:mm").format(DateTime.parse(date));
    return formattedDate;
  }

  static favNewsKey(String date) {
    final String formattedDate = DateFormat("ddMMyyyyHHmmssSSS").format(DateTime.parse(date));
    return formattedDate;
  }
}
