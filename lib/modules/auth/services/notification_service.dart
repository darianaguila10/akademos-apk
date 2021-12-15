import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String message) {
    final snackBar =SnackBar(content: Text(message), behavior: SnackBarBehavior.floating,shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))));

messengerKey.currentState!.removeCurrentSnackBar();
messengerKey.currentState!.showSnackBar(snackBar);
  }
}
