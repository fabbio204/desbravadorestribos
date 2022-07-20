import 'package:cached_network_image/cached_network_image.dart';
import 'package:desbravadores_tribos/app/app_module.dart';
import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/cadastrar_lancamento_page.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/widgets/lancamento_widget.dart';
import 'package:desbravadores_tribos/app/modules/membros/controllers/membro_detalhes_controller.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class MembroDetalhes extends StatefulWidget {
  final MembroModel membro;
  const MembroDetalhes({Key? key, required this.membro}) : super(key: key);

  @override
  State<MembroDetalhes> createState() => _MembroDetalhesState();
}

class _MembroDetalhesState extends State<MembroDetalhes> {
  MembroDetalhesController controller = Modular.get();
  @override
  void initState() {
    controller.listarLancamentos(widget.membro.nome);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            CadastrarLancamentoArgumentos args =
                CadastrarLancamentoArgumentos(nome: widget.membro.nome);

            bool? atualizar = await Modular.to.pushNamed<bool>(
              AppModule.rotaCadastrarLancamento,
              arguments: args,
            );

            if (atualizar != null && atualizar) {
              controller.listarLancamentos(widget.membro.nome);
            }
          },
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: widget.membro.foto != "" ? 250 : 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.membro.nome,
                  overflow: TextOverflow.ellipsis,
                ),
                background: widget.membro.foto != ""
                    ? Hero(
                        tag: widget.membro.nome,
                        child: CachedNetworkImage(
                          height: 60,
                          width: 60,
                          fit: BoxFit.fitWidth,
                          key: const Key('foto'),
                          imageUrl: widget.membro.foto!,
                        ),
                      )
                    : null,
              ),
            ),
            SliverToBoxAdapter(
              child: ScopedBuilder<MembroDetalhesController, Exception,
                  List<LancamentoModel>>(
                store: controller,
                onLoading: (_) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Carregando(),
                  );
                },
                onError: (_, erro) => LogErro(erro: erro),
                onState: (context, financeiro) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: financeiro.length,
                  itemBuilder: (context, index) {
                    return LancamentoWidget(model: financeiro[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
