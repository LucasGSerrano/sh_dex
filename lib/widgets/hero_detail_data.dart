import 'package:flutter/material.dart';

class HeroDetailData extends StatelessWidget {
  final String dataName;
  final String dataValue;

  const HeroDetailData(
      {Key? key, required this.dataName, required this.dataValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$dataName",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          Expanded(
            child: Text(
              "$dataValue",
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }
}
