import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:beamer/beamer.dart';

import '../../../core_lib/core.dart';
import '../components/bus_list_section.dart';

class BusScreen extends ConsumerWidget {
  const BusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MiddleHeader(
                        title: "My Buss",
                        searchHintText: "Buss",
                        onSearchChange: (val) {
                          print(val);
                          ref.read(dataProvider.notifier).filterBus(val);
                        },
                        onAddPressed: () {
                          print("Add new button pressed");
                          context.beamToNamed('/bus/form');
                        },
                        onRefreshPressed: () {
                          print("Refresh button pressed");
                          ref
                              .read(dataProvider.notifier)
                              .getAllBus(showSnack: true);
                        },
                      ),
                      Gap(defaultPadding * 2),
                      BusListSection(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
