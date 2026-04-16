import 'package:flutter/material.dart';

class PinWidget extends StatelessWidget {
  final bool isPinned;
  final VoidCallback? onTap;

  const PinWidget({super.key, required this.isPinned, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      right: 12,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isPinned ? const Color(0xFFFFF8E1) : Colors.grey[100],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Icon(
              Icons.push_pin_outlined,
              size: 18,
              color: isPinned ? Colors.amber : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
