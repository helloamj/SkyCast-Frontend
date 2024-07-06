import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FluttertoastHelper {
  // A helper method to show a toast message
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message, // The message to be displayed in the toast
      toastLength: Toast
          .LENGTH_SHORT, // The duration for which the toast should be displayed
      gravity: ToastGravity.BOTTOM, // The position of the toast on the screen
      timeInSecForIosWeb:
          1, // The time in seconds for which the toast should be displayed on iOS and web platforms
      backgroundColor: Colors.red, // The background color of the toast
      textColor: Colors.white, // The text color of the toast
      fontSize: 16.0, // The font size of the toast message
    );
  }
}
