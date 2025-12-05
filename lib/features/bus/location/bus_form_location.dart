import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../presentation/bus_form_page.dart';

class BusFormLocation extends BeamLocation<BeamState> {
  BusFormLocation([super.routeInformation]);

  @override
  List<String> get pathPatterns => ['/bus/form', '/bus/form/:busId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    // Extract busId from state if provided (/bus/form/:busId)
    final busId = state.pathParameters['busId'];

    return [
      BeamPage(
        key: const ValueKey('bus-form'),
        title: busId != null ? 'Edit Bus' : 'Add Bus',
        child: BusFormPage(busId: busId),
      ),
    ];
  }
}
