import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';
import '../presentation/bus_screen.dart';

class BusLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/bus'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('bus'),
        title: 'bus',
        child: MainLayout(
          currentIndex: 1,
          pageTitle: 'Bus',
          // child: BusListScreen(),
          child: BusScreen(),
        ),
      ),
    ];
  }
}
