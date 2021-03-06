import 'package:flutter/material.dart';

extension BuildExtension on BuildContext {
  double get screenWidth {
    var query = MediaQuery.of(this);
    return query.size.width;
  }

  double get screenHeight => MediaQuery.of(this).size.height;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get secondaryColor => Theme.of(this).secondaryHeaderColor;
}
