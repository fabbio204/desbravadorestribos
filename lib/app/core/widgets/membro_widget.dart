import 'package:cached_network_image/cached_network_image.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';

class MembroWidget extends StatelessWidget {
  final MembroModel membro;
  const MembroWidget({Key? key, required this.membro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: setImage(),
      title: Text(membro.nome),
      subtitle: Text(membro.aniversario),
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
      width: 55,
      child: Center(child: Icon(Icons.person)),
    );
  }
}
