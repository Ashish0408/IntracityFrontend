import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'BusListPage.dart';

class BusTestPageLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/BusTestPage'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('BusTestPage'),
        title: 'BusTestPage',
        child: BusTestPage(),
      ),
    ];
  }
}
