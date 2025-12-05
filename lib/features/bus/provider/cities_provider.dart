import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core_lib/core.dart';

part 'cities_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<String>> cities(CitiesRef ref) async {
  try {
    // 🔹 For now, return a hardcoded list
    final hardcodedCities = [
      'Delhi',
      'Mumbai',
      'Bangalore',
      'Kolkata',
      'Chennai',
      'Hyderabad',
      'Pune',
      'Jaipur',
      'Ahmedabad',
      'Lucknow',
    ];

    // simulate network delay for realism
    await Future.delayed(const Duration(milliseconds: 500));

    return hardcodedCities;
  } catch (e) {
    Logger.error('Error fetching cities: $e');
    return [];
  }
}
