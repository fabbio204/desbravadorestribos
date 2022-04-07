import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
 
void main() {
  late CalendarioRepository repository;

  setUpAll(() {
    repository = CalendarioRepository();
  });
}