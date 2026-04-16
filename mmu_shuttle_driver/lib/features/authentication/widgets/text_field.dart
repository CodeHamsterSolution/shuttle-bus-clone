import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool shouldHide;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.shouldHide = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: shouldHide,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
