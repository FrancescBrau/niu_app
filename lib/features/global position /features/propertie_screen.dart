import 'package:flutter/material.dart';

class PropertieScreen extends StatelessWidget {
  const PropertieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
      ),
      body: const Center(
        child: Text('Manage your properties'),
      ),
    );
  }
}
