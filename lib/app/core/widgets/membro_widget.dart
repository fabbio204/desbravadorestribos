import 'package:cached_network_image/cached_network_image.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';

class MembroWidget extends StatelessWidget {
  final MembroModel membro;
  final bool ocultarIcone;
  const MembroWidget(
      {Key? key, required this.membro, this.ocultarIcone = false})
      : super(key: key);

  static const TextStyle estilo = TextStyle(color: Colors.grey, fontSize: 12);
  static const double tamanhoIcone = 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              if (!ocultarIcone)
                Expanded(
                  child: setImage(),
                  flex: 3,
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(membro.nome),
                    if (membro.idade != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: tamanhoIcone,
                          ),
                          const SizedBox(width: 4),
                          Text('${membro.idade} anos', style: estilo),
                        ],
                      ),
                    if (membro.unidade != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.group,
                            size: tamanhoIcone,
                          ),
                          const SizedBox(width: 4),
                          Text('Unidade ${membro.unidade}', style: estilo),
                        ],
                      ),
                    if (membro.aniversario != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.cake,
                            size: tamanhoIcone,
                          ),
                          const SizedBox(width: 4),
                          Text('Aniversário ${membro.aniversario}',
                              style: estilo),
                        ],
                      )
                  ],
                ),
                flex: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget setImage() {
    if (membro.foto != null && membro.foto!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: membro.foto!,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    return const SizedBox(
      child: Center(
        child: Icon(
          Icons.person,
          size: 55,
        ),
      ),
    );
  }
}
