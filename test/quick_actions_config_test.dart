import 'package:desbravadores_tribos/quick_actions_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Cria Quick Actions Config', () {
    WidgetsFlutterBinding.ensureInitialized();

    QuickActionsConfig.init();

    expect(QuickActionsConfig.quickActions, isNotNull);
  });
}
