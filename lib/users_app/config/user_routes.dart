import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/bus_list_screen.dart';
import '../presentation/screens/contact_us_screen.dart';
import '../presentation/screens/about_us_screen.dart';
import '../presentation/screens/manage_booking_screen.dart';
import '../presentation/screens/seat_selection_screen.dart';

/// User-facing routes for the bus booking application
class RoutesLocation {
  static final List<BeamLocation> all = [
    HomeLocation(),
    BusListLocation(),
    ContactUsLocation(),
    AboutUsLocation(),
    ManageBookingLocation(),
    SeatSelectionLocation(),
  ];
}

/// Home/Search location
class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/users', '/users/home'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('home'),
        title: 'Bus Search',
        child: const HomeScreen(),
      ),
    ];
  }
}

/// Bus list/search results location
class BusListLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/users/buses'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final from = state.queryParameters['from'] ?? '';
    final to = state.queryParameters['to'] ?? '';
    final date = state.queryParameters['date'] ?? '';

    return [
      BeamPage(
        key: const ValueKey('bus-list'),
        title: 'Available Buses',
        child: BusListScreen(fromCity: from, toCity: to, travelDate: date),
      ),
    ];
  }
}

/// Contact Us location
class ContactUsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/users/contact'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('contact-us'),
        title: 'Contact Us',
        child: const ContactUsScreen(),
      ),
    ];
  }
}

/// About Us location
class AboutUsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/users/about'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('about-us'),
        title: 'About Us',
        child: const AboutUsScreen(),
      ),
    ];
  }
}

/// Manage Booking location
class ManageBookingLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/users/bookings'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('manage-booking'),
        title: 'Manage Booking',
        child: const ManageBookingScreen(),
      ),
    ];
  }
}

/// Seat Selection location
class SeatSelectionLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/users/seats/:busId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final busId = state.pathParameters['busId'] ?? '';
    final busName = state.queryParameters['busName'] ?? '';
    final departureTime = state.queryParameters['departureTime'] ?? '';
    final arrivalTime = state.queryParameters['arrivalTime'] ?? '';
    final fromCity = state.queryParameters['fromCity'] ?? '';
    final toCity = state.queryParameters['toCity'] ?? '';
    final date = state.queryParameters['date'] ?? '';
    final price = double.tryParse(state.queryParameters['price'] ?? '0') ?? 0;

    return [
      BeamPage(
        key: const ValueKey('seat-selection'),
        title: 'Seat Selection',
        child: SeatSelectionScreen(
          busId: busId,
          busName: busName,
          departureTime: departureTime,
          arrivalTime: arrivalTime,
          fromCity: fromCity,
          toCity: toCity,
          date: date,
          price: price,
        ),
      ),
    ];
  }
}
