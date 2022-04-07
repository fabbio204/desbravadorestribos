import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';

void main() {
  late HomeRepository repository;

  setUpAll(() {
    repository = HomeRepository();
  });
}
