import 'package:flutter/material.dart';
import 'package:niu_app/shared/repositories/shared_preferences.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final SharedPreferencesRepository _prefsRepo = SharedPreferencesRepository();
  final TextEditingController _controller = TextEditingController();
  List<String> alert = [];

  @override
  void initState() {
    super.initState();
    loadAlerts();
  }

  void loadAlerts() async {
    final alerts = await _prefsRepo.getAlerts();
    setState(() {
      alert = alerts;
    });
  }

  void _addAlert() async {
    if (_controller.text.isNotEmpty) {
      await _prefsRepo.addAlert(_controller.text);
      _controller.clear();
      loadAlerts();
    }
  }

  void _removeAlert(int index) async {
    await _prefsRepo.removeAlert(alert[index]);
    loadAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "New alert",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addAlert,
              child: const Text("Add alert"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: alert.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(alert[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeAlert(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
