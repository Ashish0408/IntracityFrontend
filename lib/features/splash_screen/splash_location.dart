import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';

class SplashLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/', '/splash'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('splash'),
        title: 'Splash',
        child: SplashScreen(),
      ),
    ];
  }
}
