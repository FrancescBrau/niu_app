import 'package:flutter/material.dart';

class BuildEmailField extends StatelessWidget {
  const BuildEmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
