import 'package:quick_actions/quick_actions.dart';

class QuickActionsConfig {
  static const String cadastrarEvento = 'cadastrarEvento';
  static const String cadastrarLancamento = 'cadastrarLancamento';
  static const QuickActions quickActions = QuickActions();
  static void init() {
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: cadastrarEvento,
          localizedTitle: 'Cadastrar Evento',
          icon: 'calendar_add'),
      const ShortcutItem(
          type: cadastrarLancamento,
          localizedTitle: 'Cadastrar Lançamento',
          icon: 'add_money')
    ]);
  }
}
