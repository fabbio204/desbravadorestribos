import 'dart:convert';

import 'package:dio/dio.dart';

class AppVersion {
  final Dio dio;
  static const String githubApiTags =
      'https://api.github.com/repos/fabbio204/desbravadorestribos/tags';

  AppVersion(this.dio);

  Future<String> releaseVersion() async {
    Response<String> response = await dio.get<String>(githubApiTags);

    var resultado = json.decode(response.data!);

    List<String> lista =
        (resultado as List).map((e) => e["name"] as String).toList();

    String ultimaTag = lista[0];

    return ultimaTag;
  }
}
