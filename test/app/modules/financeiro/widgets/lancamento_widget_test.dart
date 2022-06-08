import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/widgets/lancamento_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_base.dart';

void main() {
  group('Testa lancamento Widget', () {
    testWidgets('Testa LancamentoWidget com entrada', (tester) async {
      LancamentoModel model = LancamentoModel(
          data: '01/01/2022',
          descricao: 'Saldo 1',
          subCaixa: 'Geral',
          envolvido: 'Pessoa 1',
          entrada: '10');

      await tester.pumpWidget(montarBase(LancamentoWidget(model: model)));

      var labelEntrada = find.byKey(const Key('labelEntrada'));
      expect(labelEntrada, findsOneWidget);

      var labelSaida = find.byKey(const Key('labelSaida'));
      expect(labelSaida, findsNothing);

      var labelEnvolvido = find.byKey(const Key('labelEnvolvido'));
      expect(labelEnvolvido, findsOneWidget);
    });

    testWidgets('Testa LancamentoWidget com saída', (tester) async {
      LancamentoModel model = LancamentoModel(
          data: '01/01/2022',
          descricao: 'Saldo 1',
          subCaixa: 'Geral',
          envolvido: 'Pessoa 1',
          saida: '10');

      await tester.pumpWidget(montarBase(LancamentoWidget(model: model)));

      var labelSaida = find.byKey(const Key('labelSaida'));
      expect(labelSaida, findsOneWidget);

      var labelEntrada = find.byKey(const Key('labelEntrada'));
      expect(labelEntrada, findsNothing);

      var labelEnvolvido = find.byKey(const Key('labelEnvolvido'));
      expect(labelEnvolvido, findsOneWidget);
    });

    testWidgets('Testa LancamentoWidget sem envolvido', (tester) async {
      LancamentoModel model = LancamentoModel(
          data: '01/01/2022',
          descricao: 'Saldo 1',
          subCaixa: 'Geral',
          saida: '10');

      await tester.pumpWidget(montarBase(LancamentoWidget(model: model)));

      var labelSaida = find.byKey(const Key('labelSaida'));
      expect(labelSaida, findsOneWidget);

      var labelEntrada = find.byKey(const Key('labelEntrada'));
      expect(labelEntrada, findsNothing);

      var labelEnvolvido = find.byKey(const Key('labelEnvolvido'));
      expect(labelEnvolvido, findsNothing);
    });
  });
}
