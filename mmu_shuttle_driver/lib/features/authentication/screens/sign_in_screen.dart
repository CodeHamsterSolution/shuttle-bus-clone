import 'package:flutter/material.dart';
import 'package:mmu_shuttle_driver/features/authentication/providers/auth_provider.dart';
import 'package:mmu_shuttle_driver/features/authentication/widgets/sign_in_form.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  Future<void> _signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
          ),
        ),
        child: SignInFormWidget(onSubmitted: _signIn),
      ),
    );
  }
}
