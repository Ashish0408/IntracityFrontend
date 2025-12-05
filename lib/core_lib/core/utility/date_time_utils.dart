import 'package:intl/intl.dart';

class TimeUtils {
  /// Converts a user-picked time string like "1:45 PM"
  /// into API-ready "HH:mm:ss" (24-hour) format.
  static String? toApiTime(String? displayTime) {
    if (displayTime == null || displayTime.isEmpty) return null;
    try {
      final parsed = DateFormat('h:mm a').parse(displayTime);
      return DateFormat('HH:mm:ss').format(parsed);
    } catch (e) {
      return null;
    }
  }

  /// Optionally convert API time back to display (if editing a bus)
  static String? toDisplayTime(String? apiTime) {
    if (apiTime == null || apiTime.isEmpty) return null;
    try {
      final parsed = DateFormat('HH:mm:ss').parse(apiTime);
      return DateFormat('h:mm a').format(parsed);
    } catch (e) {
      return null;
    }
  }
}
