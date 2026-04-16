import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final bool isLoading;

  const HeaderWidget({super.key, required this.title, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            if (isLoading) return;
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
