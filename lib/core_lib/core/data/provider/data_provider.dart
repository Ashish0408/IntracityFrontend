import 'dart:convert';

import 'package:bus_management_admin/core_lib/auth_module/provider/auth_provider.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';
import '../../../common/models/bus/bus_model.dart';
import '../../models/api_response.dart';
import '../../services/http_service.dart';
import '../../utility/logger.dart';
import '../../utility/notification_helper.dart';
import '../model/data_state_model.dart';

part 'data_provider.g.dart';

@riverpod
class Data extends _$Data {
  late final HttpService httpService;
  // late final FlutterSecureStorage secureStorage;
  // late final AuthNotifier authNotifier;

  @override
  Future<DataStateModel> build() async {
    httpService = ref.read(httpServiceProvider);
    // authNotifier = ref.watch(appDependenciesProvider).authNotifier;
    // secureStorage = ref.read(appDependenciesProvider).secureStorage;
    state = const AsyncValue.loading();

    await getAllBus();

    return state.value ?? DataStateModel.initial();
  }

  Future<void> getAllBus({bool showSnack = false}) async {
    state = const AsyncValue.loading();
    try {
      final userToken = await ref.read(authProvider.notifier).user.token;
      Logger.info('getAllBus userToken = $userToken');

      final response = await httpService.getItems(
        endpointUrl: 'buses/all',
        headers: {"Authorization": "Bearer $userToken"},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        Logger.info('getAllBus jsonResponse = $jsonResponse');

        final apiResponse = ApiResponse<List<BusModel>>.fromJson(
          jsonResponse,
          (json) => (json as List).map((e) => BusModel.fromJson(e)).toList(),
        );

        if (showSnack) {
          NotificationHelper.showSuccessNotification(apiResponse.message);
        }

        final current = state.value ?? DataStateModel.initial();
        state = AsyncValue.data(
          current.copyWith(
            allBus: apiResponse.data,
            filteredBus: apiResponse.data,
          ),
        );
      } else {
        throw Exception('Failed to load service types');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      if (showSnack) NotificationHelper.showErrorNotification(e.toString());
    }
  }

  void filterBus(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    final filtered = state.value!.allBus
        .where(
          (type) => (type.busName ?? '').toLowerCase().contains(lowerKeyword),
        )
        .toList();
    state = AsyncValue.data(state.value!.copyWith(filteredBus: filtered));
  }

  BusModel? busByBusId(String id) =>
      state.value?.allBus.firstWhereOrNull((e) => e.busId == id);

  BusModel? getNextAvailableBus() {
    final buses = state.value?.allBus;
    if (buses == null || buses.isEmpty) {
      Logger.info('getNextAvailableBus: No buses found.');
      return null;
    }

    final now = DateTime.now();
    Logger.info('getNextAvailableBus: Current system time = $now');

    DateTime? parseTime(String? timeString) {
      if (timeString == null || timeString.isEmpty) return null;
      try {
        final parsed = DateFormat('HH:mm:ss').parse(timeString);
        var result = DateTime(
          now.year,
          now.month,
          now.day,
          parsed.hour,
          parsed.minute,
          parsed.second,
        );

        // ✅ If time already passed today → assume it's tomorrow
        if (result.isBefore(now)) {
          result = result.add(const Duration(days: 1));
        }

        Logger.info('Parsed "$timeString" as $result (adjusted)');
        return result;
      } catch (e) {
        Logger.warning('Failed to parse time "$timeString": $e');
        return null;
      }
    }

    Logger.info('buses "${buses.toList()}"');

    // Compute next upcoming bus (including next day)
    final upcoming = buses.where((bus) {
      final dep = parseTime(bus.busDepartureTime);
      final isUpcoming = dep != null && dep.isAfter(now);
      Logger.info(
        'Bus ${bus.busName ?? 'Unnamed'} dep=${bus.busDepartureTime} -> $dep => Upcoming=$isUpcoming',
      );
      return isUpcoming;
    }).toList();

    if (upcoming.isEmpty) {
      Logger.info('getNextAvailableBus: No upcoming buses found.');
      return null;
    }

    // Sort by soonest adjusted departure
    upcoming.sort((a, b) {
      final aTime = parseTime(a.busDepartureTime);
      final bTime = parseTime(b.busDepartureTime);
      if (aTime == null || bTime == null) return 0;
      return aTime.compareTo(bTime);
    });

    final nextBus = upcoming.first;
    Logger.info(
      'getNextAvailableBus: Next bus = ${nextBus.busName} (${nextBus.busFromCity} → ${nextBus.busToCity}) at ${nextBus.busDepartureTime}',
    );

    return nextBus;
  }

  /// Search buses by source city, destination city, and date/time
  List<BusModel> searchBuses({
    required String sourceCity,
    required String destinationCity,
    required DateTime travelDateTime,
  }) {
    final buses = state.value?.allBus ?? [];

    Logger.info('═════════════════════════════════════════');
    Logger.info('🔍 SEARCH BUSES REQUEST');
    Logger.info('  From City: "$sourceCity"');
    Logger.info('  To City: "$destinationCity"');
    Logger.info(
      '  Travel DateTime: ${DateFormat('dd MMM yyyy HH:mm').format(travelDateTime)}',
    );
    Logger.info('  Total Buses Available: ${buses.length}');
    Logger.info('─────────────────────────────────────────');

    if (buses.isEmpty) {
      Logger.info('❌ No buses available in system.');
      Logger.info('═════════════════════════════════════════');
      return [];
    }

    DateTime? parseTime(String? timeString) {
      if (timeString == null || timeString.isEmpty) return null;
      try {
        final parsed = DateFormat('HH:mm:ss').parse(timeString);
        var result = DateTime(
          travelDateTime.year,
          travelDateTime.month,
          travelDateTime.day,
          parsed.hour,
          parsed.minute,
          parsed.second,
        );

        // ✅ If time already passed today → assume it's tomorrow
        if (result.isBefore(travelDateTime)) {
          result = result.add(const Duration(days: 1));
          Logger.info(
            '  ⏰ Bus departure time ${timeString} is before search time, adjusted to tomorrow',
          );
        }

        return result;
      } catch (e) {
        Logger.warning('⚠️ Failed to parse time "$timeString": $e');
        return null;
      }
    }

    // Filter buses matching source, destination, and departure time
    final filtered = buses.where((bus) {
      final matchesSource = (bus.busFromCity ?? '').toLowerCase().contains(
        sourceCity.toLowerCase(),
      );
      final matchesDestination = (bus.busToCity ?? '').toLowerCase().contains(
        destinationCity.toLowerCase(),
      );
      final depTime = parseTime(bus.busDepartureTime);
      final isUpcoming = depTime != null && depTime.isAfter(travelDateTime);

      final matches = matchesSource && matchesDestination && isUpcoming;
      if (matches) {
        Logger.info(
          '✅ ${bus.busName} | ${bus.busFromCity} → ${bus.busToCity} | Departs: ${bus.busDepartureTime} (${depTime.toString()})',
        );
      } else {
        Logger.info(
          '❌ ${bus.busName} | From: ${bus.busFromCity}, To: ${bus.busToCity}, Depart: ${bus.busDepartureTime} | Source Match: $matchesSource, Dest Match: $matchesDestination, Upcoming: $isUpcoming',
        );
      }
      return matches;
    }).toList();

    // Sort by departure time
    filtered.sort((a, b) {
      final aTime = parseTime(a.busDepartureTime);
      final bTime = parseTime(b.busDepartureTime);
      if (aTime == null || bTime == null) return 0;
      return aTime.compareTo(bTime);
    });

    Logger.info('─────────────────────────────────────────');
    Logger.info(
      '📊 SEARCH RESULTS: Found ${filtered.length} buses matching criteria',
    );
    Logger.info('═════════════════════════════════════════');
    return filtered;
  }

  /// Get unique city names from all buses (for dropdown options)
  List<String> getUniqueCities() {
    final buses = state.value?.allBus ?? [];
    final cities = <String>{};
    for (var bus in buses) {
      if (bus.busFromCity != null) cities.add(bus.busFromCity!);
      if (bus.busToCity != null) cities.add(bus.busToCity!);
    }
    return cities.toList()..sort();
  }
}
