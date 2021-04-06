import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sh_dex/models/HeroModel.dart';
import 'package:sh_dex/services/hero_service.dart';

final heroProvider = Provider((_) => HeroService());
final heroFutureProvider = FutureProvider<List<HeroModel>>(
    (ref) async => ref.read(heroProvider).getHeroes());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) => watch(heroFutureProvider).map(
        data: (data) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 240,
            title: Column(
              children: [
                Image(
                  height: 180,
                  image: AssetImage('lib/assets/logo.png'),
                ),
                Text(
                  'Superhero Dex',
                  style: GoogleFonts.bangers(color: Colors.white, fontSize: 32),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed("/heroList", arguments: data.value),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "All Heroes",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Alignment',
                    style: TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      "/heroList",
                      arguments: data.value
                          .where((element) =>
                              element.biography?.alignment == 'good')
                          .toList(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Good",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      "/heroList",
                      arguments: data.value
                          .where((element) =>
                              element.biography?.alignment == 'bad')
                          .toList(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Evil",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Publisher',
                    style: TextStyle(fontSize: 32),
                  ),
                  ...data.value
                      .expand((hero) => hero.biography?.publisher != null &&
                              hero.biography!.publisher!.isNotEmpty
                          ? [hero.biography?.publisher]
                          : [])
                      .toSet()
                      .toList()
                      .map(
                        (e) => Container(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                              "/heroList",
                              arguments: data.value
                                  .where((element) =>
                                      element.biography?.publisher == e)
                                  .toList(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e,
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
        loading: (loading) => Center(child: CircularProgressIndicator()),
        error: (_) => Center(
          child: Text(_.error.toString(), style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
