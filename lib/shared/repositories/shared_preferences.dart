import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository extends DatabaseRepository {
  static const String usersKey = 'users';
  static const String alertKey = 'alerts';

//USER FUNCTION

  @override
  Future<bool> createUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(usersKey) ?? [];

    if (users.contains(email)) {
      return false;
    }

    users.add(email);
    await prefs.setStringList(usersKey, users);

    await prefs.setString('$email-user', '');
    await prefs.setString('$email-phone', '');
    await prefs.setString('$email-address', '');
    await prefs.setString('$email-zip', '');
    await prefs.setString('$email-city', '');
    return true;
  }

  @override
  Future<Map<String, String?>?> readUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(usersKey) ?? [];
    if (!users.contains(email)) {
      return null;
    }

    final user = prefs.getString('$email-user');
    final phone = prefs.getString('$email-phone');
    final address = prefs.getString('$email-address');
    final zip = prefs.getString('$email-zip');
    final city = prefs.getString('$email-city');
    return {
      'user': user,
      'phone': phone,
      'address': address,
      'zip': zip,
      'city': city
    };
  }

  @override
  Future<bool> updateUser(
    String email, {
    String? user,
    String? phone,
    String? address,
    String? zip,
    String? city,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(usersKey) ?? [];
    if (!users.contains(email)) {
      return false;
    }

    if (user != null) {
      await prefs.setString('$email-user', user);
    }
    if (phone != null) {
      await prefs.setString('$email-phone', phone);
    }
    if (address != null) {
      await prefs.setString('$email-address', address);
    }
    if (zip != null) {
      await prefs.setString('$email-zip', zip);
    }
    if (city != null) {
      await prefs.setString('$email-city', city);
    }

    return true;
  }

  @override
  Future<bool> deleteUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(usersKey) ?? [];
    if (!users.contains(email)) {
      users.remove(email);
      await prefs.setStringList(usersKey, users);
    }

    users.remove(email);
    await prefs.setStringList(usersKey, users);

    await prefs.remove('$email-user');
    await prefs.remove('$email-phone');
    await prefs.remove('$email-address');
    await prefs.remove('$email-zip');
    await prefs.remove('$email-city');
    return true;
  }

// ALERTS FUNCTION

  @override
  @override
  Future<bool> addAlert(Map<String, dynamic> alert) async {
    final prefs = await SharedPreferences.getInstance();
    final alerts = prefs.getStringList(alertKey) ?? [];
    final alertJson = jsonEncode(alert);
    alerts.add(alertJson);
    return await prefs.setStringList(alertKey, alerts);
  }

  @override
  Future<List<Map<String, dynamic>>> getAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    final alerts = prefs.getStringList(alertKey) ?? [];
    return alerts
        .map((alert) => jsonDecode(alert) as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<bool> removeAlert(Map<String, dynamic> alert) async {
    final prefs = await SharedPreferences.getInstance();
    final alerts = prefs.getStringList(alertKey) ?? [];
    final alertJson = jsonEncode(alert);
    if (!alerts.contains(alertJson)) {
      return false;
    }
    alerts.remove(alertJson);
    return await prefs.setStringList(alertKey, alerts);
  }
}
