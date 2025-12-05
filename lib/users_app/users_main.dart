import 'dart:io';
import 'dart:developer' show log;

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import '../firebase_options.dart';
import '../core_lib/core.dart';
import '../my_http_overrides.dart';
import 'config/user_routes.dart';
import 'config/user_theme.dart';

/// Users App - Main entry point for passenger side of the bus booking application
/// This app reuses backend logic (BusModel, DataProvider, SeatService)
/// but provides a customer-focused UI/UX for booking buses

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpOverrides();

  // Initialize the ProviderContainer
  final container = ProviderContainer();

  // Pass the container to AppDependencies
  final appDependencies = AppDependencies(container);

  runApp(
    ProviderScope(
      overrides: [appDependenciesProvider.overrideWithValue(appDependencies)],
      child: const UsersApp(),
    ),
  );
}

class UsersApp extends ConsumerStatefulWidget {
  const UsersApp({super.key});

  @override
  ConsumerState<UsersApp> createState() => _UsersAppState();
}

class _UsersAppState extends ConsumerState<UsersApp> {
  late final BeamerDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = BeamerDelegate(
      transitionDelegate: const NoAnimationTransitionDelegate(),
      locationBuilder: BeamerLocationBuilder(beamLocations: RoutesLocation.all),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Bus Booking - Passenger',
          theme: UsersTheme.lightTheme,
          darkTheme: UsersTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerDelegate: _routerDelegate,
          routeInformationParser: BeamerParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
            initialRouteInformation: const RouteInformation(
              location: '/users/home',
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
