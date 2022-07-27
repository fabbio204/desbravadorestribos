import 'package:desbravadores_tribos/app/core/auth/auth_config.dart';
import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class BiometriaPage extends StatefulWidget {
  const BiometriaPage({Key? key}) : super(key: key);

  @override
  State<BiometriaPage> createState() => _BiometriaPageState();
}

class _BiometriaPageState extends State<BiometriaPage> {
  final ValueNotifier<bool> autenticacaoFalhou = ValueNotifier(false);
  @override
  void initState() {
    // Remove a splash screen, pois a inicialização foi concluída
    FlutterNativeSplash.remove();

    super.initState();
    checkBiometria();
  }

  void checkBiometria() async {
    AuthConfig authConfig = Modular.get();

    final bool podeAutenticarPorBiometria = await authConfig.podeAutenticar();
    autenticacaoFalhou.value = false;

    if (podeAutenticarPorBiometria) {
      final bool autenticado = await authConfig.autenticar();

      if (!autenticado) {
        autenticacaoFalhou.value = true;
      } else {
        Modular.to.pushNamedAndRemoveUntil(
          HomeModule.rotaResumo,
          (Route rota) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: autenticacaoFalhou,
        builder: (context, falhaAutenticacao, child) {
          if (falhaAutenticacao) {
            return Center(
              child: ElevatedButton(
                onPressed: checkBiometria,
                child: const Text('Tentar autenticar novamente'),
              ),
            );
          } else {
            return const Carregando();
          }
        },
      ),
    );
  }
}
