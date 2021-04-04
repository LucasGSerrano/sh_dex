import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sh_dex/models/Appearance.dart';
import 'package:sh_dex/models/Biography.dart';
import 'package:sh_dex/models/Connections.dart';
import 'package:sh_dex/models/HeroModel.dart';
import 'package:sh_dex/models/Powerstats.dart';
import 'package:sh_dex/models/Work.dart';
import 'package:sh_dex/widgets/powerstats_chart.dart';
import 'package:sh_dex/widgets/hero_detail_data.dart';

class HeroDetails extends StatelessWidget {
  final HeroModel heroData;

  const HeroDetails({Key? key, required this.heroData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(heroData.name ?? "Hero"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              // child: ClipOval(
              child: Hero(
                tag: heroData.images!.lg!,
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: heroData.images!.lg!,
                ),
              ),
              // ),
            ),
          ),
          if (heroData.appearance != null)
            ...appearanceBuilder(heroData.appearance!),
          if (heroData.biography != null)
            ...biographyBuilder(heroData.biography!),
          if (heroData.powerstats != null)
            ...powerstatsBuilder(heroData.powerstats!),
          if (heroData.work != null) ...workBuilder(heroData.work!),
          if (heroData.connections != null)
            ...connectionsBuilder(heroData.connections!),
        ],
      ),
    );
  }

  List<Widget> appearanceBuilder(Appearance appearance) {
    return [
      const SizedBox(height: 32.0),
      Text(
        "Appearance",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),
      if (appearance.gender != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Gender", dataValue: appearance.gender!),
      ],
      if (appearance.race != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Race", dataValue: appearance.race!),
      ],
      if (appearance.height != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Height", dataValue: appearance.height!.join(' | ')),
      ],
      if (appearance.weight != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Weight", dataValue: appearance.weight!.join(' | ')),
      ],
      if (appearance.eyeColor != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Eye Color", dataValue: appearance.eyeColor!),
      ],
      if (appearance.hairColor != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Hair Color", dataValue: appearance.hairColor!),
      ],
    ];
  }

  List<Widget> biographyBuilder(Biography biography) {
    return [
      const SizedBox(height: 32.0),
      Text(
        "Biography",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),
      if (biography.fullName != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Full Name", dataValue: biography.fullName!),
      ],
      if (biography.alterEgos != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Alter Egos", dataValue: biography.alterEgos!),
      ],
      if (biography.aliases != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Aliases", dataValue: biography.aliases!.join(" | ")),
      ],
      if (biography.placeOfBirth != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Place Of Birth", dataValue: biography.placeOfBirth!),
      ],
      if (biography.firstAppearance != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "First Appearance",
            dataValue: biography.firstAppearance!),
      ],
      if (biography.publisher != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Publisher", dataValue: biography.publisher!),
      ],
      if (biography.alignment != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Alignment", dataValue: biography.alignment!),
      ],
    ];
  }

  List<Widget> powerstatsBuilder(Powerstats powerstats) {
    Map<String, double> dataMap = {};
    if (powerstats.intelligence != null)
      dataMap["Intelligence"] = powerstats.intelligence!.toDouble();
    if (powerstats.strength != null)
      dataMap["Strength"] = powerstats.strength!.toDouble();
    if (powerstats.speed != null)
      dataMap["Speed"] = powerstats.speed!.toDouble();
    if (powerstats.durability != null)
      dataMap["Durability"] = powerstats.durability!.toDouble();
    if (powerstats.power != null)
      dataMap["Power"] = powerstats.power!.toDouble();
    if (powerstats.combat != null)
      dataMap["Combat"] = powerstats.combat!.toDouble();

    return [
      const SizedBox(height: 32.0),
      Text(
        "Powerstats",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),
      const SizedBox(height: 12.0),
      BarChartSample1(powerstats: powerstats)
      // PieChart(dataMap: dataMap),
    ];
  }

  List<Widget> workBuilder(Work work) {
    return [
      const SizedBox(height: 32.0),
      Text(
        "Work",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),
      if (work.occupation != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Occupation", dataValue: work.occupation!),
      ],
      if (work.base != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(dataName: "Base", dataValue: work.base!),
      ],
    ];
  }

  List<Widget> connectionsBuilder(Connections connections) {
    return [
      const SizedBox(height: 32.0),
      Text(
        "Connections",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),
      if (connections.groupAffiliation != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Group Affiliation",
            dataValue: connections.groupAffiliation!),
      ],
      if (connections.relatives != null) ...[
        const SizedBox(height: 12.0),
        HeroDetailData(
            dataName: "Relatives", dataValue: connections.relatives!),
      ],
    ];
  }
}
