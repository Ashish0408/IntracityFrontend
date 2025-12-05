import 'dart:io';
import 'dart:developer' show log;

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';

import '../../../core_lib/core.dart';

import 'routes/routes.dart';
import 'my_http_overrides.dart';

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final BeamerDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    // Create a single router delegate instance and reuse it across rebuilds.
    final appDependencies = ref.read(appDependenciesProvider);
    _routerDelegate = createRouterDelegate(appDependencies);
    log('Initialized stable BeamerDelegate in initState');
    // Log delegate changes so we can see when Beamer updates the location/pages
    _routerDelegate.addListener(_onRouterDelegateChange);
  }

  @override
  void dispose() {
    _routerDelegate.removeListener(_onRouterDelegateChange);
    _routerDelegate.dispose();
    super.dispose();
  }

  void _onRouterDelegateChange() {
    try {
      // Some Beamer properties can throw if not available; protect with try.
      final loc = _routerDelegate.currentBeamLocation;
      log(
        'BeamerDelegate change: currentBeamLocation=${loc.runtimeType}, state=${loc.state}',
      );
    } catch (e) {
      log('BeamerDelegate change: error reading currentBeamLocation: $e');
    }
    try {
      log(
        'BeamerDelegate change: configuration=${_routerDelegate.configuration}',
      );
    } catch (e) {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCheckAsyncValue = ref.watch(authCheckProvider);
    return authCheckAsyncValue.when(
      data: (isAuthenticated) {
        log('authCheck finished (build): isAuthenticated=$isAuthenticated');

        return Sizer(
          builder: (context, orientation, screenType) {
            log(
              'Building MaterialApp.router (isAuthenticated=$isAuthenticated)',
            );
            return MaterialApp.router(
              debugShowCheckedModeBanner: true,
              title: 'Flutter Admin Panel',
              scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: bgColor,
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ).apply(bodyColor: Colors.white),
                canvasColor: secondaryColor,
              ),
              routeInformationProvider: PlatformRouteInformationProvider(
                initialRouteInformation: const RouteInformation(location: '/'),
              ),
              routerDelegate: _routerDelegate,
              routeInformationParser: BeamerParser(),
              // builder: (context, child) {
              //   // Small debug overlay showing the current Beam location URI.
              //   final currentUri =
              //       _routerDelegate.currentBeamLocation?.state.toString() ??
              //       '-';
              //   return Stack(
              //     children: [
              //       child ?? const SizedBox.shrink(),
              //       Positioned(
              //         top: 8,
              //         right: 8,
              //         child: Container(
              //           padding: const EdgeInsets.symmetric(
              //             horizontal: 8,
              //             vertical: 4,
              //           ),
              //           color: Colors.black54,
              //           child: Text(
              //             'route: $currentUri',
              //             style: const TextStyle(
              //               color: Colors.white,
              //               fontSize: 12,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   );
              // },
            );
          },
        );
      },
      loading: () => const Material(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) =>
          const Material(child: Center(child: Text('Error occurred'))),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:sizer/sizer.dart';

// // import 'features/booking/presentation/seat_selection_screen.dart';

// import 'unitTesting/seatSelection.dart';

// void main() {
//   runApp(const BusApp());
// }

// class BusApp extends HookWidget {
//   const BusApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Dynamic Bus Layout Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             scaffoldBackgroundColor: Colors.white,
//             inputDecorationTheme: InputDecorationTheme(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           home: SeatSelectionScreen(
//             busId: 34,
//             layoutId: 'L002',
//             date: DateTime.now().toString(),
//           ),
//           // home: SeatSelectionScreen(busId: '34', layoutId: 'L001'),
//         );
//       },
//     );
//   }
// }
