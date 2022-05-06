import 'package:cached_network_image/cached_network_image.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';

class MembroWidget extends StatelessWidget {
  final MembroModel membro;
  const MembroWidget({Key? key, required this.membro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: setImage(),
              flex: 3,
            ),
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
                          size: 14,
                        ),
                        Text('${membro.idade} anos'),
                      ],
                    ),
                  if (membro.unidade != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.group,
                          size: 14,
                        ),
                        Text('Unidade ${membro.unidade}'),
                      ],
                    ),
                  if (membro.aniversario != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.group,
                          size: 14,
                        ),
                        Text('Aniversário ${membro.aniversario}'),
                      ],
                    )
                ],
              ),
              flex: 8,
            ),
          ],
        ),
      ],
    );
  }

  Widget setImage() {
    if (membro.foto != null && membro.foto!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: membro.foto!,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    return const SizedBox(
      child: Center(
          child: Icon(
        Icons.person,
        size: 55,
      )),
    );
  }
}
