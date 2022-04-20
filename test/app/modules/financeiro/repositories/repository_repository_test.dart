import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
 
void main() {
  late FinanceiroRepository repository;

  setUpAll(() {
    repository = FinanceiroRepository();
  });
}