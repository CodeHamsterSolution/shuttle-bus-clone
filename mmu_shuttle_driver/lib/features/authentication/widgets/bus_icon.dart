import 'package:flutter/material.dart';

class BusIconWidget extends StatelessWidget {
  const BusIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF0D47A1),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.directions_bus, size: 40, color: Colors.white),
    );
  }
}
