abstract class DatabaseRepository {
  Future<bool> createUser(String email);

  Future<Map<String, String?>?> readUser(String email);

  Future<bool> updateUser(String email,
      {String? user, String? phone, String? address});

  Future<bool> deleteUser(String email);
}
