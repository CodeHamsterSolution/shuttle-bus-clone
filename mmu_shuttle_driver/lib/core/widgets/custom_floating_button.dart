import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF003399),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
