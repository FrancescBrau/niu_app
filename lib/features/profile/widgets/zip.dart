import 'package:flutter/material.dart';

class Zip extends StatelessWidget {
  const Zip({
    super.key,
    required this.zipController,
  });

  final TextEditingController zipController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: zipController,
        decoration: const InputDecoration(
            labelText: 'ZIP', prefixIcon: Icon(Icons.place)),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insert ZIP.';
          }
          if (!RegExp(r'^\d{5}$').hasMatch(value)) {
            return 'Insert valid ZIP.';
          }
          return null;
        });
  }
}
