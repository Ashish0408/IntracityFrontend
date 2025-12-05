import 'dart:developer';

class SeatService {
  static const String baseUrl = 'http://192.168.29.134:8080/api';

  /// Fetch seat prices for a specific bus
  /// For now returns dummy data - replace with actual API call when backend is ready
  static Future<Map<String, String>> getBusSeatPrices(String busId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy data - different prices for different buses
    final dummyPrices = {
      '26': {
        'SU1': '1399',
        'SU2': '1399',
        'SU3': '1399',
        'SU4': '1399',
        'SU5': '1399',
        'SU6': '1399',
        'SL1': '1499',
        'SL2': '1499',
        'SL3': '1499',
        'SL4': '1499',
        'SL5': '1499',
        'SL6': '1499',
        '1': '999',
        '2': '999',
        '3': '999',
        '4': '999',
        '5': '999',
        '6': '999',
        '7': '999',
        '8': '999',
        '9': '999',
        '10': '999',
        '11': '999',
        '12': '999',
        '13': '999',
        '14': '999',
        '15': '999',
        '16': '999',
        'DU1': '1199',
        'DU2': '1199',
        'DU3': '1199',
        'DU4': '1199',
        'DU5': '1199',
        'DU6': '1199',
        'DU7': '1199',
        'DU8': '1199',
        'DU9': '1199',
        'DU10': '1199',
        'DU11': '1199',
        'DU12': '1199',
        'DL1': '1299',
        'DL2': '1299',
        'DL3': '1299',
        'DL4': '1299',
      },
      'bus-001': {
        'SU1': '1299',
        'SU2': '1299',
        'SL1': '1399',
        'SL2': '1399',
        '1': '899',
        'DU1': '1099',
        'DL1': '1199',
      },
      'bus-002': {
        'SU1': '1599',
        'SU2': '1599',
        'SL1': '1799',
        'SL2': '1799',
        '1': '1099',
        'DU1': '1399',
        'DL1': '1499',
      },
    };

    // Get prices for this bus, or use default
    final prices = dummyPrices[busId] ?? dummyPrices['26'] ?? {};
    log('✅ Loaded seat prices for bus $busId: $prices');
    return prices;
  }

  /// Lock seats for a user (start session)
  /// For now returns success - replace with actual API call when backend is ready
  static Future<bool> lockSeats({
    required String busId,
    required List<String> selectedSeats,
    required String userId,
    int lockDurationMinutes = 3,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Dummy success response
    final lockId = 'lock_${DateTime.now().millisecondsSinceEpoch}';
    final expiresAt = DateTime.now().add(
      Duration(minutes: lockDurationMinutes),
    );

    log('✅ Seats locked successfully');
    log('   Lock ID: $lockId');
    log('   Bus ID: $busId');
    log('   Seats: $selectedSeats');
    log('   User: $userId');
    log('   Expires at: $expiresAt');

    return true;
  }

  /// Release/unlock seats (called on cancel or after booking)
  /// For now returns success - replace with actual API call when backend is ready
  static Future<bool> unlockSeats({required String lockId}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    log('✅ Seats unlocked successfully');
    log('   Lock ID: $lockId');

    return true;
  }

  /// Fetch booked seats for a specific bus and layout
  /// For now returns dummy booked seats - replace with actual API call when backend is ready
  static Future<List<String>> getBookedSeats({
    required String busId,
    required String layoutId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Dummy booked seats data - different for each bus
    final dummyBookedSeats = {
      '26': ['DU3', '3', 'DL2', 'SU1', '5', '10'],
      '27': ['2', '7', 'DU2', 'SL3', '12'],
      'bus-001': ['SU2', '1', 'DU1'],
    };

    final booked = dummyBookedSeats[busId] ?? ['DU3', '3', 'DL2'];
    log('✅ Loaded booked seats for bus $busId: $booked');
    return booked;
  }

  /// Get user's gender (for seat allocation rules)
  /// For now returns dummy data - replace with actual user data from auth provider
  static Future<String> getUserGender({required String userId}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    // Dummy data - in real app, get from auth provider or user profile
    // Returns 'M' for male, 'F' for female, 'O' for other
    const userGenderMap = {
      'user-123': 'M', // Male
      'user-456': 'F', // Female
      'user-789': 'O', // Other
    };

    final gender = userGenderMap[userId] ?? 'O';
    log('✅ User $userId gender: $gender');
    return gender;
  }
}
