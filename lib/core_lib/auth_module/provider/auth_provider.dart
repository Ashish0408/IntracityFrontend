import 'package:bus_management_admin/core_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencies/app_dependencies.dart';
import '../model/auth_state_model.dart';
import '../../common/models/user/user_model.dart';
import '../service/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService})
    : super(AuthState(isAuthenticated: false, isLoading: true)) {
    _checkLoginStatus(); // Automatically check login status when AuthNotifier is created
  }

  get isLoading => state.isLoading;
  get user => state.user;
  get userType => state.userType;
  get isAuthenticated => state.isAuthenticated;

  // Check login status on startup
  Future<void> _checkLoginStatus() async {
    // log('_checkLoginStatus ');
    try {
      final isAuthenticated = await authService.isAuthenticated();
      // log('_checkLoginStatus isAuthenticated    =: ${isAuthenticated} ');

      if (isAuthenticated) {
        UserModel? user = await authService.getStoredUser('admin');
        // log('_checkLoginStatus if user    =: ${user} ');

        state = state.copyWith(
          isAuthenticated: true,
          user: user,
          isLoading: false,
        );
      } else {
        // log('_checkLoginStatus else  ');

        state = state.copyWith(isAuthenticated: false, isLoading: false);
        // log('_checkLoginStatus else  state : ${state}');
      }
    } catch (e) {
      // Handle error
      state = state.copyWith(isLoading: false);
      // log('_checkLoginStatus catch  state : ${state}');
    }
  }

  // User Login method
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final isAuthenticated = await authService.authenticate(email, password);
    final user = isAuthenticated
        ? await authService.getStoredUser('admin')
        : null;
    Logger.info('login isAuthenticated = $isAuthenticated, user = $user');

    state = AuthState(
      isAuthenticated: isAuthenticated,
      user: user,
      isLoading: false,
      userType: isAuthenticated ? UserType.user : null,
    );
    Logger.info('login state = ${state.toString()}');

    return isAuthenticated;
  }

  // User Signup method
  Future<bool> signup(String username, String email, String password) async {
    state = state.copyWith(isLoading: true);

    final isSignedUp = await authService.register(username, email, password);
    // final user = isSignedUp ? await authService.getStoredUser() : null;

    // state = AuthState(
    //   isAuthenticated: isSignedUp,
    //   user: user,
    //   isLoading: false,
    //   userType: isSignedUp ? UserType.user : null,
    // );
    state = state.copyWith(isLoading: false);
    return isSignedUp;
  }

  // Forgot password method
  Future<bool> forgotPassword(String email) async {
    final isPasswordReset = await authService.resetPassword(email);

    if (isPasswordReset) {
      // Maybe you want to show a confirmation message to the user
      return true;
    } else {
      // Handle the case where resetting the password fails
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    // log('logout');

    // Set loading to true while logging out
    state = state.copyWith(isLoading: true);

    await authService.logoutFromServer();

    // Reset state after logout and set loading to false
    state = AuthState(isAuthenticated: false, user: null, isLoading: false);
    // log('logout state ${state.toString()}');
  }

  void updateProfileCompletion(bool isComplete) {
    print('updateProfileCompletion called with isComplete: $isComplete');
    state = state.copyWith(isProfileComplete: isComplete);
    print('AuthState after update: ${state.toString()}');
    // You might also want to persist this change to your backend
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
final authCheckProvider = FutureProvider<bool>((ref) async {
  final appDependencies = ref.watch(appDependenciesProvider);
  return appDependencies.authService.isAuthenticated();
});
