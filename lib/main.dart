import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Mantém a splash scrren na tela
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Inicializa os processos
  await GoogleSheetsApi.init();

  await initializeDateFormatting();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
