import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../../../core_lib/core.dart';
import '../components/add_bus_form.dart';

class BusFormPage extends ConsumerWidget {
  final String? busId; // If null, it's "Add new", otherwise it's "Edit"

  const BusFormPage({super.key, this.busId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = busId != null;

    // Fetch bus data if editing
    BusModel? bus;
    if (isEditing) {
      // Get the bus list from provider and find the matching bus
      final busListAsync = ref.watch(dataProvider);
      bus = busListAsync.whenData((dataState) {
        final parsedId = int.tryParse(busId!);
        return dataState.allBus.firstWhere(
              (b) => b.busId == parsedId,
              orElse: () => null as dynamic,
            )
            as BusModel?;
      }).value;
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          isEditing ? 'Edit Bus'.toUpperCase() : 'Add Bus'.toUpperCase(),
          style: TextStyle(color: primaryColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Go back to bus screen
            context.beamBack();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BusSubmitForm(
            bus: bus,
            onFormSubmitted: () {
              // Navigate back after successful submission
              context.beamBack();
            },
            onFormCancelled: () {
              // Navigate back on cancel
              context.beamBack();
            },
          ),
        ),
      ),
    );
  }
}
