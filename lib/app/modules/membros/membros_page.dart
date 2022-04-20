import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/membros/membro_controller.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class MembrosPage extends StatefulWidget {
  final String title;
  const MembrosPage({Key? key, this.title = 'MembrosPage'}) : super(key: key);
  @override
  MembrosPageState createState() => MembrosPageState();
}

class MembrosPageState extends ModularState<MembrosPage, MembroController> {
  @override
  void initState() {
    super.initState();
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<MembroController, Exception, List<MembroModel>>(
      store: store,
      onLoading: (_) => const Carregando(),
      onError: (_, erro) => LogErro(erro: erro),
      onState: (context, membros) {
        return ListView.builder(
            itemCount: membros.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: setImage(membros[index]),
                title: Text(membros[index].nome),
                subtitle: Text(membros[index].dataNascimento),
              );
            });
      },
    );
  }

  setImage(MembroModel membro) {
    if (membro.foto != null && membro.foto!.isNotEmpty) {
      return Image.network(membro.foto!);
    }

    return const Icon(Icons.person);
  }
}
