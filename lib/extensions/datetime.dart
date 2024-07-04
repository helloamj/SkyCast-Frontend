import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
  String get dateTime => DateFormat('EEEE dd •').add_jm().format(this);
}

extension GreetGood on DateTime {
  String get greetGood {
    final hour = this.hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
