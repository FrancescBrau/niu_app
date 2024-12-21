import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  const Address({
    super.key,
    required this.addressController,
  });

  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: addressController,
      decoration: const InputDecoration(
          labelText: 'Address', prefixIcon: Icon(Icons.location_on)),
    );
  }
}
