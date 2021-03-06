import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/menu_lateral_widget.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Remove a splash screen, pois a inicialização foi concluída
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> titulo = context.watch<ValueNotifier<String>>();
    ValueNotifier<List<Widget>?> acoes = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo.value, key: const Key('tituloAppBar')),
        actions: acoes.value,
      ),
      body: const RouterOutlet(),
      drawer: const MenuLateralWidget(),
    );
  }
}
