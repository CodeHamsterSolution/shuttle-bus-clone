import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mmu_shuttle_driver/core/routing/route_navigation_helper.dart';
import 'package:mmu_shuttle_driver/core/utils/toast.dart';
import 'package:mmu_shuttle_driver/core/widgets/custom_elevated_button.dart';
import 'package:mmu_shuttle_driver/features/authentication/widgets/bus_icon.dart';
import 'package:mmu_shuttle_driver/features/authentication/widgets/text_field.dart';

class SignInFormWidget extends StatefulWidget {
  final Future<void> Function(
    BuildContext context,
    String email,
    String password,
  )?
  onSubmitted;
  const SignInFormWidget({super.key, this.onSubmitted});

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  //methods
  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          _isLoading = true;
        });
        await widget.onSubmitted?.call(
          context,
          _emailController.text,
          _passwordController.text,
        );
        await RouteNavigationHelper.checkAndNavigateActiveRoute(context);
        showSuccessToast(context, 'Sign in successfully');

        setState(() {
          _isLoading = false;
        });

      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }

        showErrorToast(context, e.toString());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BusIconWidget(),
              const SizedBox(height: 16),
              const Text(
                "MMU Driver",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                "Sign in to your account",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Email',
                hintText: 'driver@mmu.edu.my',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationBuilder().email().minLength(6).build(),
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                label: 'Password',
                hintText: '........',
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                shouldHide: true,
                validator: ValidationBuilder().minLength(6).build(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: CustomElevatedButton(
                  onPressed: _onSubmit,
                  text: "Sign In",
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
