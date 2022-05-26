import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_module.dart';
 
void main() {

  setUpAll(() {
    initModule(MembrosModule());
  });
}