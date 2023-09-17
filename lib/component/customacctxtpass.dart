import 'package:flutter/material.dart';

class ForgetPassHaveAcc extends StatelessWidget {
  const ForgetPassHaveAcc({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "Click Here",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
