import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository extends DatabaseRepository {
  static const String usersKey = 'users';

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
  Future<bool> updateUser(String email,
      {String? user,
      String? phone,
      String? address,
      String? zip,
      String? city}) async {
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
      await prefs.setString('$email-zip', '');
    }
    if (city != null) {
      await prefs.setString('$email-city', '');
    }

    return true;
  }

  @override
  Future<bool> deleteUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(usersKey) ?? [];
    if (!users.contains(email)) {
      return false;
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
}
