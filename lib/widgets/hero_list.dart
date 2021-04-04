import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sh_dex/models/models.dart';
import 'package:shimmer/shimmer.dart';

class HeroList extends StatelessWidget {
  final AsyncData<List<HeroModel>> data;

  const HeroList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.value.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(
          '${data.value[index].name}',
        ),
        leading: ((data.value[index].images != null &&
                data.value[index].images!.sm != null)
            ? ClipOval(
                clipBehavior: Clip.hardEdge,
                child: Hero(
                  tag: data.value[index].images!.lg!,
                  child: CachedNetworkImage(
                    width: 45,
                    height: 45,
                    fit: BoxFit.fill,
                    imageUrl: data.value[index].images!.md!,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade500,
                      enabled: true,
                      child: CircleAvatar(radius: 35),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )
            : Container(
                width: 35,
                height: 35,
                child: Placeholder(),
              )),
        onTap: () => Navigator.pushNamed(context, '/heroDetail',
            arguments: data.value[index]),
      ),
    );
  }
}
