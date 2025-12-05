import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../core_lib/core.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'email'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final String email = _formKey.currentState!.value['email'];
                    final String password =
                        _formKey.currentState!.value['password'];

                    final bool isAuthenticated = await ref
                        .read(authProvider.notifier)
                        .login(email, password);

                    if (isAuthenticated) {
                      context.beamToNamed(
                        '/dashboard',
                      ); // Navigate to dashboard on successful login
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login failed')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please complete the form')),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  context.beamToNamed('/signup'); // Navigate to signup screen
                },
                child: const Text('Don\'t have an account? Sign up here!'),
              ),
              TextButton(
                onPressed: () {
                  context.beamToNamed(
                    '/forgot-password',
                  ); // Navigate to forgot password screen
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
