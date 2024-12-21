abstract class DatabaseRepository {
  //USERS

  Future<bool> createUser(String email);

  Future<Map<String, String?>?> readUser(String email);

  Future<bool> updateUser(
    String email, {
    String? user,
    String? phone,
    String? address,
    String? zip,
    String? city,
  });

  Future<bool> deleteUser(String email);

  //ALERTS

  Future<bool> addAlert(Map<String, dynamic> alert);
  Future<List<Map<String, dynamic>>> getAlerts();
  Future<bool> removeAlert(Map<String, dynamic> alert);
}
