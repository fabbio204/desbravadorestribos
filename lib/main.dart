import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await GoogleSheetsApi.init();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
