import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sh_dex/pages/hero_detail.dart';
import 'package:sh_dex/pages/home_page.dart';
import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/heroDetail': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          return HeroDetails(heroData: arguments as HeroModel);
        }
      },
    );
  }
}
