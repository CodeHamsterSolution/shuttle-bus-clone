import 'package:flutter/material.dart';

class LogoutButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const LogoutButtonWidget({
    super.key,
    this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
