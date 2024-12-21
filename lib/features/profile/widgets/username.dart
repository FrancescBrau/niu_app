import 'package:flutter/material.dart';

class Username extends StatelessWidget {
  const Username({
    super.key,
    required this.userController,
  });

  final TextEditingController userController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userController,
      decoration: const InputDecoration(labelText: 'Username'),
      keyboardType: TextInputType.text,
    );
  }
}
