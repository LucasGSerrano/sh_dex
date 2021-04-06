import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sh_dex/pages/pages.dart';
import 'package:sh_dex/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Dex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.marvelTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => Home(),
        '/heroList': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          return HeroList(arguments as List<HeroModel>);
        },
        '/heroDetail': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          return HeroDetails(heroData: arguments as HeroModel);
        }
      },
    );
  }
}
