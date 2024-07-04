import 'package:intl/intl.dart';

extension UnixTimeExtension on int {
  String unixToFormattedTime() {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
    // hrs:mins AM/PM
    return DateFormat.jm().format(dateTime);
  }
}
