import 'package:flutter/material.dart';

extension BuildExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  Color get primaryColor => Theme.of(this).primaryColor;
}
