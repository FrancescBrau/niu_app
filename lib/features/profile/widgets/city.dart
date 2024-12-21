import 'package:flutter/material.dart';

class City extends StatelessWidget {
  const City({
    super.key,
    required this.cityController,
  });

  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cityController,
      decoration: const InputDecoration(
          labelText: 'City', prefixIcon: Icon(Icons.location_city)),
      keyboardType: TextInputType.text,
    );
  }
}
