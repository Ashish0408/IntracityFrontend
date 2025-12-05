import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth_module/provider/auth_provider.dart';
import '../auth_module/service/auth_service.dart';
import '../core/services/http_service.dart';

class AppDependencies {
  final FlutterSecureStorage secureStorage;
  final AuthService authService;
  final AuthNotifier authNotifier;
  final HttpService httpService; // Keep HttpService

  // Private constructor
  AppDependencies._({
    required this.secureStorage,
    required this.authService,
    required this.authNotifier,
    required this.httpService,
  });

  // Factory method to create AppDependencies
  factory AppDependencies(ProviderContainer container) {
    final secureStorage = const FlutterSecureStorage();
    final httpService = HttpService();

    return AppDependencies._(
      secureStorage: secureStorage,
      httpService: httpService,
      authService: AuthService(
        secureStorage: secureStorage,
        httpService: httpService,
      ),
      authNotifier: AuthNotifier(
        authService: AuthService(
          secureStorage: secureStorage,
          httpService: httpService,
        ),
      ),
    );
  }
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
    'AppDependencies must be provided via ProviderScope.overrideWithValue.',
  );
});

// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });
