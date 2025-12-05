import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../../main/main_layout.dart';
import '../presentation/seat_selection_screen.dart';

class BookingLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/booking', '/booking/:id/:layoutId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final busId = state.pathParameters['id'];
    final layoutId = state.pathParameters['layoutId']; // ✅ fixed

    return [
      BeamPage(
        key: const ValueKey('booking'),
        title: 'Booking',
        child: MainLayout(
          currentIndex: 1,
          pageTitle: 'Booking',
          child: busId == null || layoutId == null
              ? const Center(child: Text('Select a bus to view details.'))
              : SeatSelectionScreen(busId: busId, layoutId: layoutId),
        ),
      ),
    ];
  }
}
