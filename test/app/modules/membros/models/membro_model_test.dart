import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Teste MembroModel', () {
    var membro = MembroModel(
        nome: 'Teste 1',
        aniversario: '01/01/1990',
        foto: 'https:www.foto.com',
        idade: 20,
        unidade: 'U1');

    var membro2 = MembroModel(
        nome: 'Teste 2',
        aniversario: '01/01/1990',
        foto: 'https:www.foto.com',
        idade: 20,
        unidade: 'U1');

    var membro3 = MembroModel.fromJson(r"""
        {"nome": "Teste 3","aniversario": "01/01/1990","foto": "https:www.foto.com","idade": 20,"unidade": "U1"}""");

    var membro4 = membro3.copyWith();

    expect(membro, isNot(equals(membro2)));
    expect(membro, equals(membro));
    expect(membro3, equals(membro4));
    expect(membro.toString(), isNotNull);
    expect(membro.hashCode, isNot(0));
    expect(true, membro == membro);
    expect(false, membro == membro2);
    expect(membro3, isNotNull);
    expect(membro3.toString(), isNotNull);
    expect(membro3.toJson(), isNotNull);
  });
}
