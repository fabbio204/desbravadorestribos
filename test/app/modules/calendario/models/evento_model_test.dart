import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testa EventoModel', () {
    var model1 =
        EventoModel(dia: DateTime(2022, 1, 1), titulo: 'Primeira Reunião');

    var model2 = model1.copyWith();

    var model3 = EventoModel(
      dia: DateTime(2022, 2, 1),
      titulo: "Primeira Reunião de Pais",
    );

    var model4 = EventoModel.fromJson(r"""
      {
        "dia": 1640979000000,
        "titulo": "Primeira Reunião de Pais"
      }
    """);

    expect(model1, isNotNull);
    expect(true, model1 == model2);
    expect(model1, equals(model2));
    expect(model1.toString(), isNotEmpty);
    expect(model2.toJson(), isNotNull);
    expect(model3.toJson(), isNotNull);
    expect(model4.hashCode, isNot(0));
  });
}
