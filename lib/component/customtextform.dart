import 'package:flutter/material.dart';

class CustomTxtForm extends StatelessWidget {
  const CustomTxtForm({
    super.key,
    required this.controller,
    this.validator,
    required this.title,
    required this.hint,
    required this.obscureText,
    this.icon,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? icon;
  final String title;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
