import 'package:cached_network_image/cached_network_image.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MembroWidget extends StatelessWidget {
  final MembroModel membro;
  final bool ocultarIcone;
  const MembroWidget(
      {Key? key, required this.membro, this.ocultarIcone = false})
      : super(key: key);

  static const TextStyle estilo = TextStyle(color: Colors.grey, fontSize: 12);
  static const double tamanhoIcone = 12;
  static const double altura = 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getCor(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                if (!ocultarIcone)
                  Expanded(
                    child: SizedBox(height: 60, child: setImage()),
                    flex: 2,
                  ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        membro.nome,
                        key: const Key('nome'),
                      ),
                      if (membro.idade != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: tamanhoIcone,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${membro.idade} anos',
                              style: estilo,
                              key: const Key('idade'),
                            ),
                          ],
                        ),
                      if (membro.unidade != null && membro.unidade!.isNotEmpty)
                        Row(
                          children: [
                            const Icon(
                              Icons.group,
                              size: tamanhoIcone,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Unidade ${membro.unidade}',
                              style: estilo,
                              key: const Key('unidade'),
                            ),
                          ],
                        ),
                      if (membro.aniversario != null &&
                          membro.aniversario!.isNotEmpty)
                        Row(
                          children: [
                            const Icon(
                              Icons.cake,
                              size: tamanhoIcone,
                            ),
                            const SizedBox(width: 4),
                            Text('Aniversário ${membro.aniversario}',
                                style: estilo, key: const Key('aniversario')),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget setImage() {
    if (membro.foto != null && membro.foto!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          key: const Key('foto'),
          imageUrl: membro.foto!,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
        ),
      );
    }

    return const Center(
      child: Icon(
        Icons.person,
        size: 55,
      ),
    );
  }

  Color getCor() {
    DateTime agora = DateTime.now();
    DateTime hoje = DateTime(agora.year, agora.month, agora.day);
    var formatter = DateFormat('dd/MM/yyyy');
    String dataFormatada = formatter.format(hoje);

    if (dataFormatada == membro.aniversario) {
      return Colors.yellow.shade200;
    } else {
      return Colors.transparent;
    }
  }
}
