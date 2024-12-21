import 'package:flutter/material.dart';

class MailboxScreen extends StatelessWidget {
  const MailboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mailbox')),
      body: const Center(
        child: Text('Show messages'),
      ),
    );
  }
}
