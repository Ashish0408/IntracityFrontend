import 'dart:developer' show log;
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class NotFoundLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    log('NotFoundLocation.buildPages called for uri: ${state.uri}');

    return [
      BeamPage(
        key: const ValueKey('not-found'),
        title: 'Not Found',
        child: Scaffold(
          appBar: AppBar(title: const Text('Page not found')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 64),
                const SizedBox(height: 16),
                const Text('404 — Page not found'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Beamer.of(context).beamToNamed('/splash'),
                  child: const Text('Go to Splash'),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
