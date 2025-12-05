import 'dart:developer' show log;
import 'package:beamer/beamer.dart';
import '../../../core_lib/core.dart';

import '../features/auth/location/auth_location.dart';
import '../features/booking/location/booking_location.dart';
import '../features/bus/location/bus_location.dart';
import '../features/bus/location/bus_form_location.dart';
import '../features/dashboard/location/dashboard_location.dart';
import '../features/profile/location/profile_location.dart';
import '../features/settings/location/settings_location.dart';
import '../features/splash_screen/splash_location.dart';
// unitTesting locations are not used in production routing; remove import
import '../features/not_found/not_found_location.dart';

// BeamerDelegate createRouterDelegate(AppDependencies dependencies) {
//   return BeamerDelegate(
//     initialPath: '/splash', // Show splash screen first
//     notFoundRedirectNamed: '/splash',
//     setBrowserTabTitle: true,
//     // transitionDelegate: NoAnimationTransitionDelegate(),
//     // beamBackTransitionDelegate: ReverseTransitionDelegate(),
//     // guards: [
//     //   BeamGuard(
//     //     pathPatterns: [
//     //       '/dashboard',
//     //       '/dashboard/*',
//     //       '/bus',
//     //       '/bus/*',
//     //       '/profile',
//     //       '/settings',
//     //       '/booking',
//     //       '/booking/:id',
//     //     ],
//     //     guardNonMatching: false,
//     //     check: (context, location) {
//     //       // log('createRouterDelegate  /dashboard dependencies.authNotifier.state.isAuthenticated    =: ${dependencies.authNotifier.state.isAuthenticated} ');

//     //       // Wait for the login check to finish
//     //       if (dependencies.authNotifier.isLoading) {
//     //         // log('createRouterDelegate dependencies.authNotifier.state.isLoading    =: ${dependencies.authNotifier.state.isLoading} ');
//     //         // Beamer.of(context).beamToNamed('/splash');
//     //         return false; // Still loading, prevent navigation
//     //       }

//     //       // Allow access if authenticated
//     //       return dependencies.authNotifier.isAuthenticated;
//     //     },
//     //     beamToNamed: (origin, target) {
//     //       if (dependencies.authNotifier.isLoading) {
//     //         return '/splash'; // ✅ Stay on splash during check
//     //       }
//     //       return '/login'; // ✅ Redirect unauth users to login
//     //     },
//     //     onCheckFailed: (context, location) {
//     //       if (dependencies.authNotifier.state.isLoading) {
//     //         // log('createRouterDelegate in onCheckFailed if dependencies.authNotifier.state.isLoading    =: ${dependencies.authNotifier.state.isLoading} ');
//     //         // Beamer.of(context).beamToNamed('/splash'); // ✅ Always show splash
//     //         // Instead of redirecting to '/splash', just prevent navigation and display a loading indicator in the UI
//     //         return;
//     //       } else {
//     //         // log('createRouterDelegate in onCheckFailed else beamToNamed  /login  =: ${dependencies.authNotifier.state.isLoading} ');
//     //         // Redirect to login if not au
//     //         // thenticated
//     //         Beamer.of(context).beamToNamed('/login');
//     //       }
//     //     },
//     //   ),
//     //   BeamGuard(
//     //     pathPatterns: ['/login', '/signup'],
//     //     guardNonMatching: false,
//     //     check: (context, location) {
//     //       // Ensure that users who are already authenticated cannot access the login screen
//     //       // log('createRouterDelegate  /login !dependencies.authNotifier.state.isAuthenticated    =: ${!dependencies.authNotifier.state.isAuthenticated} ');

//     //       // Ensure router waits for the login check to finish
//     //       if (dependencies.authNotifier.isLoading) {
//     //         Beamer.of(context).beamToNamed('/splash'); // ✅ Always show splash
//     //         return false; // Still loading, show splash or loading screen
//     //       }

//     //       return !dependencies.authNotifier.isAuthenticated;
//     //     },
//     //     // beamToNamed: (origin, target) {
//     //     //   if (dependencies.authNotifier.isLoading) {
//     //     //     return '/splash';
//     //     //   }
//     //     //   return '/dashboard';
//     //     // },
//     //     onCheckFailed: (context, location) {
//     //       Beamer.of(context).beamToNamed('/dashboard');
//     //     },
//     //   ),
//     //   BeamGuard(
//     //     pathPatterns: ['/logout'],
//     //     check: (context, location) {
//     //       // log('logout from routs');
//     //       // dependencies.authNotifier.logout(); // Wait for the logout to complete
//     //       return false; // Redirect after logging out
//     //     },
//     //     onCheckFailed: (context, location) {
//     //       Beamer.of(context).beamToNamed('/login');
//     //     },
//     //   ),
//     // ],
//     locationBuilder: (routeInformation, _) {
//       final beamLocations = [
//         SplashLocation(),
//         AuthLocation(authNotifier: dependencies.authNotifier),
//         DashboardLocation(),
//         ProfileLocation(),
//         SettingsLocation(),
//         BusLocation(),
//         BookingLocation(),
//       ];

//       return BeamerLocationBuilder(
//         beamLocations: beamLocations,
//       ).call(routeInformation, null);
//     },
//   );
// }

// // === ROUTER DELEGATE ===
BeamerDelegate createRouterDelegate(AppDependencies dependencies) {
  log(
    'createRouterDelegate called. initialPath=/, notFoundRedirectNamed=/splash',
  );
  return BeamerDelegate(
    initialPath: '/',
    notFoundRedirectNamed: '/splash',
    setBrowserTabTitle: false,
    guards: [
      BeamGuard(
        pathPatterns: [
          '/dashboard*',
          '/profile*',
          '/settings*',
          '/bus*',
          '/booking*',
        ],
        check: (context, state) {
          return dependencies.authNotifier.isAuthenticated;
        },
        beamToNamed: (origin, target) => '/login',
      ),
    ],
    locationBuilder: (routeInformation, _) {
      // Log incoming route information
      log('locationBuilder called with location: ${routeInformation.location}');

      final beamLocations = [
        SplashLocation(),
        AuthLocation(authNotifier: dependencies.authNotifier),
        DashboardLocation(),
        ProfileLocation(),
        SettingsLocation(),
        BusLocation(),
        BusFormLocation(),
        BookingLocation(),
        NotFoundLocation(),
      ];

      final builder = BeamerLocationBuilder(beamLocations: beamLocations);
      final location = builder.call(routeInformation, null);
      log(
        'Resolved BeamLocation: ${location.runtimeType}, state: ${location.state}',
      );

      return location;
    },
  );
}
