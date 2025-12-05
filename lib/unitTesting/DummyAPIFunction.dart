import 'dart:async';
import 'dart:math';

class DummyBusApi {
  static Future<Map<String, dynamic>> fetchBusDetails({
    required String busId,
    required String date,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final random = Random();

    // Generate some dummy booked seats
    final List<Map<String, dynamic>> bookedSeats = [];
    final seatTypes = [
      'S',
      'SL',
      'SU',
      'DSU',
      'DSL',
    ]; // S = Seat, SL = Sleeper Lower, SU = Sleeper Upper, DSU = Double Sleeper Upper, DSL = Double Sleeper Lower,
    final genders = ['male', 'female'];

    for (int i = 0; i < 8; i++) {
      final type = seatTypes[random.nextInt(seatTypes.length)];
      final seatNo = '$type${random.nextInt(24) + 1}';
      bookedSeats.add({
        'seatType': type,
        'seatNo': seatNo,
        'status': 'booked',
        'bookForGender': genders[random.nextInt(genders.length)],
      });
    }

    return {
      'busId': busId,
      'date': date,
      'status': 'active',
      'amenities': ['WiFi', 'Air Conditioning', 'Restroom', 'Reclining Seats'],
      'route': {
        'origin': 'Delhi',
        'destination': 'Laknow',
        'stops': ['Chicago, IL', 'Denver, CO', 'Las Vegas, NV'],
      },
      'layoutId': 'L001',
      'seatConfig': {
        'totalSeats': 48,
        'availableSeats': 48 - bookedSeats.length,
        'bookedSeats': bookedSeats.length,
        'seatLayout': [
          {'seatType': 'S', 'noOfSeats': '24', 'pricePerSeat': 1001},
          {'seatType': 'SL', 'noOfSeats': '6', 'pricePerSeat': 1500},
          {'seatType': 'SU', 'noOfSeats': '6', 'pricePerSeat': 1000},
          {'seatType': 'DSL', 'noOfSeats': '6', 'pricePerSeat': 1100},
          {'seatType': 'DSU', 'noOfSeats': '6', 'pricePerSeat': 1010},
        ],
      },
      'bookedSeatConfig': {'seatNumbers': bookedSeats},
    };
  }

  static Future<Map<String, dynamic>> lockSeats({
    required String busId,
    required String date,
    required List<String> seatNos,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "sessionId": "SES_${Random().nextInt(999999)}",
      "expiresIn": 120, // 2 minutes lock
      "status": "locked",
      "lockedSeats": seatNos,
    };
  }

  /// Search buses by origin, destination and date
  static Future<List<Map<String, dynamic>>> searchBuses({
    required String from,
    required String to,
    required String date,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final random = Random();
    final busServices = [
      'Delhi-lucknow 2',
      'AC Luxury Express',
      'Sleeper Comfort',
      'Premium VIP',
      'Economy Plus',
    ];

    final List<Map<String, dynamic>> buses = [];

    // Generate 5 dummy buses
    for (int i = 0; i < 5; i++) {
      final departureHour = 22 + i;
      final arrivalHour = (departureHour + 9) % 24;
      final availableSeats = random.nextInt(20) + 5;
      final price = 299 + (random.nextInt(5) * 100);

      buses.add({
        'busId': 'BUS_${i + 1}',
        'busName': busServices[i],
        'busType': '2+2, Sleeper/Seater, AC (60 seats)',
        'busDepartureTime': '${departureHour.toString().padLeft(2, '0')}:30',
        'busArrivalTime': '${arrivalHour.toString().padLeft(2, '0')}:30',
        'busFromCity': from,
        'busToCity': to,
        'busPrice': price.toDouble(),
        'busAvailableSeats': availableSeats,
        'duration': '09 Hrs',
        'boardingPoints': ['Delhi City Center', 'Delhi Airport'],
        'droppingPoints': ['Lucknow Station', 'Lucknow City'],
        'amenities': [
          'WiFi',
          'Power Plug',
          'Water Bottle',
          'Blanket',
          'Pillow',
        ],
        'rating': 4.5,
        'via': 'Via',
        'date': date,
        'layoutId': 'LAYOUT_${i + 1}',
      });
    }

    return buses;
  }
}
