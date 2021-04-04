import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sh_dex/models/Powerstats.dart';

class BarChartSample1 extends StatefulWidget {
  final Powerstats powerstats;

  final gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
      colors: <Color>[Color(0xff00ee00), Color(0xffeeee00), Color(0xff00ee00)],
      stops: [0, 0.5, 1]);

  BarChartSample1({Key? key, required this.powerstats}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        // color: const Color(0xff81e5cd),
        color: const Color(0xff000000),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(mainBarData()),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.green,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
      barsSpace: 100,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
        6,
        (i) {
          switch (i) {
            case 0:
              return makeGroupData(
                  0, widget.powerstats.intelligence!.toDouble(),
                  isTouched: i == touchedIndex, barColor: Colors.blue);
            case 1:
              return makeGroupData(1, widget.powerstats.strength!.toDouble(),
                  isTouched: i == touchedIndex, barColor: Colors.red);
            case 2:
              return makeGroupData(2, widget.powerstats.speed!.toDouble(),
                  isTouched: i == touchedIndex, barColor: Colors.yellow);
            case 3:
              return makeGroupData(3, widget.powerstats.durability!.toDouble(),
                  isTouched: i == touchedIndex, barColor: Colors.brown);
            case 4:
              return makeGroupData(4, widget.powerstats.power!.toDouble(),
                  isTouched: i == touchedIndex, barColor: Colors.white);
            case 5:
              return makeGroupData(5, widget.powerstats.combat!.toDouble(),
                  isTouched: i == touchedIndex, barColor: Colors.orange);
            default:
              return BarChartGroupData(x: 0);
          }
        },
      );

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Intelligence';
                  break;
                case 1:
                  weekDay = 'Strength';
                  break;
                case 2:
                  weekDay = 'Speed';
                  break;
                case 3:
                  weekDay = 'Durability';
                  break;
                case 4:
                  weekDay = 'Power';
                  break;
                case 5:
                  weekDay = 'Combat';
                  break;
                default:
                  weekDay = "";
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot?.touchedBarGroupIndex ?? 0;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Int';
              case 1:
                return 'Str';
              case 2:
                return 'Spd';
              case 3:
                return 'Dur';
              case 4:
                return 'Pow';
              case 5:
                return 'Com';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
