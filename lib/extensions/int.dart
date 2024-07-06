import 'package:intl/intl.dart';

// Extension on the int data type to convert Unix time to formatted time
extension UnixTimeExtension on int {
  // Method to convert Unix time to formatted time
  String unixToFormattedTime() {
    // Convert the Unix time (in seconds) to a DateTime object
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);

    // Format the DateTime object to a string representation of hours:minutes AM/PM
    return DateFormat.jm().format(dateTime);
  }
}
