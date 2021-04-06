import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sh_dex/models/models.dart';
import 'package:sh_dex/widgets/widgets.dart';

class HeroListView extends StatelessWidget {
  final List<HeroModel> heroList;

  const HeroListView({Key? key, required this.heroList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return heroList.isEmpty
        ? Center(
            child: Text(
              'No heros found!',
              style: Theme.of(context).textTheme.headline2,
            ),
          )
        : ListView.builder(
            itemCount: heroList.length,
            itemBuilder: (_, index) => ListTile(
              title: Text(
                '${heroList[index].name}',
              ),
              leading: ((heroList[index].images != null &&
                      heroList[index].images!.sm != null)
                  ? ClipOval(
                      clipBehavior: Clip.hardEdge,
                      child: Hero(
                        tag: heroList[index].slug!,
                        child: CachedNetworkImage(
                          width: 45,
                          height: 45,
                          fit: BoxFit.fill,
                          imageUrl: heroList[index].images!.md!,
                          placeholder: (context, url) => CustomShimmer(
                            child: CircleAvatar(radius: 35),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )
                  : Container(
                      width: 35,
                      height: 35,
                      child: Placeholder(),
                    )),
              onTap: () => Navigator.pushNamed(context, '/heroDetail',
                  arguments: heroList[index]),
            ),
          );
  }
}
