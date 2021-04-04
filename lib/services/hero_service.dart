import 'package:sh_dex/models/HeroModel.dart';
import 'package:sh_dex/services/api_service.dart';
import 'package:sh_dex/services/web_service.dart';

class HeroService extends Webservice {
  final Webservice service = Webservice();

  final url = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api";

  Future<HeroModel> getHero(int id) async {
    final heroJson = await APIService().fetchData(url: url + "/$id/image");

    return HeroModel.fromJson(heroJson);
  }

  Future<List<HeroModel>> getHeroes() async {
    final heroJson = await APIService().fetchData(url: url + "/all.json");

    return (heroJson as List<dynamic>)
        .map((e) => HeroModel.fromJson(e))
        .toList();
  }
}
