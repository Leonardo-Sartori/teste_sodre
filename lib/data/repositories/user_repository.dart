import 'package:teste_sodre/data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<User> save({required User user});
}