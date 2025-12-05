import '../../common/models/user/user_model.dart';
import '../../common/models/vendor/vendor_model.dart';

enum UserType { user, vendor }

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final dynamic user; // Can be UserModel or VendorModel
  final UserType? userType;

  final bool isProfileComplete;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.user,
    this.userType,
    this.isProfileComplete = true,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    dynamic user,
    UserType? userType,
    bool? isProfileComplete,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  @override
  String toString() =>
      'AuthState(isAuthenticated: $isAuthenticated, isLoading: $isLoading, user: $user)';
}
