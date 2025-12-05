import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core_lib/core.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  Future<void> _checkAuthentication() async {
    if (!mounted) return;

    // Wait for 2 seconds to simulate splash screen duration
    // await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check the authentication state and navigate accordingly
    final authState = ref.read(authProvider);
    log('_checkAuthentication authState = $authState');
    log(
      '_checkAuthentication authState.isAuthenticated = ${authState.isAuthenticated}',
    );

    if (!mounted) return;

    if (authState.isAuthenticated) {
      // Navigate to dashboard if authenticated
      log('_checkAuthentication beamToNamed /dashboard');
      // Use the Beamer extension on BuildContext to ensure we target the
      // correct router delegate and add a short delay so the router can
      // process any pending updates before navigation.
      Future.delayed(const Duration(milliseconds: 50), () {
        if (!mounted) return;
        log('_checkAuthentication performing beamToNamed /dashboard now');
        context.beamToNamed('/dashboard');
      });
    } else {
      // Navigate to login if not authenticated
      log('_checkAuthentication beamToNamed /login');
      Future.delayed(const Duration(milliseconds: 50), () {
        if (!mounted) return;
        log('_checkAuthentication performing beamToNamed /login now');
        context.beamToNamed('/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log('SplashScreen.build called; mounted=${mounted}');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo or any widget for splash screen
            Image.asset('assets/images/ValuexLogo.png', height: 150),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
