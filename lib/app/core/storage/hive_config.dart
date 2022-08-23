import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('configuracoes');
  }

  static void set(String chave, dynamic valor) async {
    await _box!.put(chave, valor);
  }

  static T get<T>(String chave, {T? valorPadrao}) {
    return _box!.get(chave, defaultValue: valorPadrao);
  }
}
