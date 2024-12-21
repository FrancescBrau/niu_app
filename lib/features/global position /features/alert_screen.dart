import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../shared/repositories/shared_preferences.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final SharedPreferencesRepository _prefsRepo = SharedPreferencesRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, dynamic>> alert = [];
  String _alertType = 'Informative';

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
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      final newAlert = {
        'title': _titleController.text,
        'content': _contentController.text,
        'date': DateTime.now().toIso8601String(),
        'type': _alertType,
      };
      await _prefsRepo.addAlert(newAlert);
      _titleController.clear();
      _contentController.clear();
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contentController,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                          labelText: "Content", border: OutlineInputBorder()),
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _alertType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _alertType = newValue!;
                    });
                  },
                  items: <String>['Informative', 'Urgent']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: _addAlert,
                  child: const Text("Add alert"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: alert.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(alert[index]["title"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date: ${DateFormat('dd-MM-yyyy, HH:mm.').format(DateTime.parse(alert[index]["date"]))}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            "Type: ${alert[index]["type"]}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          Text(alert[index]["content"]),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeAlert(index),
                      ),
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
