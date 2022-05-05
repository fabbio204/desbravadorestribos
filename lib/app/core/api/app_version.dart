import 'package:dio/dio.dart';

class AppVersion {
  static const String _githubApiTags =
      'https://api.github.com/repos/fabbio204/desbravadorestribos/tags';

  Future<String> releaseVersion() async {
    Dio dio = Dio();

    Response response = await dio.get(_githubApiTags);

    List<String> lista =
        (response.data as List).map((e) => e["name"] as String).toList();

    String ultimaTag = lista[0];

    return ultimaTag;
  }
}
