import 'package:flutter/material.dart';

class ConfirmationMessage extends StatelessWidget {
  const ConfirmationMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(color: Colors.green),
      textAlign: TextAlign.center,
    );
  }
}
