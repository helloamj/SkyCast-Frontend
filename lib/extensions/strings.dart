// This extension adds a `capitalize` getter to the `String` class
extension Capitalize on String {
  // The `capitalize` getter returns a new string with the first character capitalized
  String get capitalize {
    // Check if the string has a length greater than 0
    return length > 0
        // If it does, capitalize the first character and concatenate it with the rest of the string
        ? '${this[0].toUpperCase()}${substring(1)}'
        // If the string is empty, return an empty string
        : '';
  }
}
