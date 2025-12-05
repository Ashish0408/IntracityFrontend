import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';
import '../dashboard_screen.dart';

class DashboardLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => const ['/dashboard', '/dashboard/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final path = state.uri.path.isEmpty ? '/dashboard' : state.uri.path;
    print('DashboardLocation Current state path: $path');

    return [
      BeamPage(
        key: ValueKey(path),
        title: 'Dashboard',
        child: MainLayout(
          currentIndex: 1,
          pageTitle: 'Dashboard',
          child: const DashboardScreen(),
        ),
      ),
    ];
  }
}
