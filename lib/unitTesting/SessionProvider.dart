import 'package:riverpod/riverpod.dart';
import 'dart:async';

import 'SeatSession.dart';

class SeatSessionNotifier extends StateNotifier<SeatSession?> {
  Timer? _timer;

  SeatSessionNotifier() : super(null);

  void startSession(SeatSession session) {
    state = session;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (DateTime.now().isAfter(session.expiresAt)) {
        endSession();
      }
    });
  }

  void endSession() {
    _timer?.cancel();
    state = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final seatSessionProvider =
    StateNotifierProvider<SeatSessionNotifier, SeatSession?>(
      (ref) => SeatSessionNotifier(),
    );
