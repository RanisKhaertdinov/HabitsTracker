import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user.dart';

class UserDataStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _email = 'email';

  Future<void> saveUser(int id, String name, String email) async {
    await _storage.write(key: _id, value: id as String);
    await _storage.write(key: _name, value: name);
    await _storage.write(key: _email, value: email);
  }

  Future<User> getUserData() async {
    return User(
      id: await getUserId(),
      email: await getUserEmail(),
      name: await getUserName(),
    );
  }

  Future<int> getUserId() async {
    return await _storage.read(key: _id) as int;
  }

  Future<String?> getUserName() async {
    return await _storage.read(key: _name);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: _email);
  }

  Future<void> deleteUserData() async {
    await _storage.deleteAll();
  }
}
