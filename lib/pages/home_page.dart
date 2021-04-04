import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sh_dex/models/models.dart';
import 'package:sh_dex/services/hero_service.dart';
import 'package:sh_dex/widgets/hero_item_loading.dart';
import 'package:sh_dex/widgets/hero_list.dart';

final heroProvider = Provider((_) => HeroService());
final heroFutureProvider = FutureProvider<List<HeroModel>>(
    (ref) async => ref.read(heroProvider).getHeroes());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heroes"),
      ),
      body: Consumer(
        builder: (context, watch, child) => watch(heroFutureProvider).map(
          data: (data) => HeroList(data: data),
          loading: (loading) => ListView(
            children: List.generate(20, (index) => HeroItemLoading()),
          ),
          error: (_) => Center(
            child: Text(
              _.error.toString(),
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
