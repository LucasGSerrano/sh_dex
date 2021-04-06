import 'package:flutter/material.dart';
import 'package:sh_dex/widgets/widgets.dart';

class HeroItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: CustomShimmer(
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
