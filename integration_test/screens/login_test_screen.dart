import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class LoginTestScreen {
  static Finder loginPageIcon = find.widgetWithText(CircleAvatar, 'WIO');
  static Finder emailField = find.widgetWithText(TextFormField, 'Email');
  static Finder passwordField = find.widgetWithText(TextFormField, 'Password');
  static Finder loginButton = find.widgetWithText(ElevatedButton, 'Log In');
  static Finder logoutButton = find.widgetWithIcon(IconButton, Icons.logout_outlined);
  static Finder homeScreenValue = find.text('Home Screen');
}
