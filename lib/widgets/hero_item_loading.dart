import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HeroItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade500,
        enabled: true,
        child: Row(
          children: [
            ClipOval(
              child:
                  Container(color: Colors.grey.shade300, width: 45, height: 45),
            ),
            SizedBox(width: 12.0),
            Text('Loading Heroes...'),
          ],
        ),
      ),
    );
  }
}
