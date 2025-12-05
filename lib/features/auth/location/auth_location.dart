import 'dart:developer' show log;
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../core_lib/core.dart';

import '../presentation/forgot_password_screen.dart';
import '../presentation/login_screen.dart';
import '../presentation/signup_screen.dart';

class AuthLocation extends BeamLocation<BeamState> {
  final AuthNotifier authNotifier;

  AuthLocation({required this.authNotifier});

  @override
  List<String> get pathPatterns => [
    '/login',
    '/logout',
    '/signup',
    '/forgot-password',
  ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    log('AuthLocation.buildPages called for uri: ${state.uri}');

    // Determine which screen to display based on the current path
    return [
      if (state.uri.path == '/signup')
        BeamPage(
          key: const ValueKey('signup'),
          title: 'Sign Up',
          child: SignupScreen(),
        )
      else if (state.uri.path == '/forgot-password')
        BeamPage(
          key: const ValueKey('forgot-password'),
          title: 'Forgot Password',
          child: ForgotPasswordScreen(),
        )
      else
        BeamPage(
          key: const ValueKey('login'),
          title: 'Login',
          child: LoginScreen(),
        ),
    ];
  }
}
