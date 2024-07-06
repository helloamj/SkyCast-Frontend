import 'package:intl/intl.dart';

// Extension to format DateTime objects
extension FormatDateTime on DateTime {
  // Getter to format DateTime as a string
  String get dateTime => DateFormat('EEEE dd •').add_jm().format(this);
}

// Extension to greet based on the time of day
extension GreetGood on DateTime {
  // Getter to greet based on the time of day
  String get greetGood {
    final hour = this.hour;
    if (hour < 12) {
      return 'Good Morning'; // Greet "Good Morning" if hour is before 12
    } else if (hour < 17) {
      return 'Good Afternoon'; // Greet "Good Afternoon" if hour is between 12 and 17
    } else {
      return 'Good Evening'; // Greet "Good Evening" if hour is after 17
    }
  }
}
