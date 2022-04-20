import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
 
void main() {
  late MembroRepository repository;

  setUpAll(() {
    repository = MembroRepository();
  });
}