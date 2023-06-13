import 'package:injectable/injectable.dart';
import 'package:teste_sodre/data/datasources/user_datasource.dart';
import 'package:teste_sodre/data/models/user.dart';
import 'package:teste_sodre/data/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository{

  final UserDatasource userDatasource;

  UserRepositoryImpl({required this.userDatasource});
  
  @override
  Future<List<User>> getAllUsers() async {
    return userDatasource.getAllUsers();
  }

  @override
  Future<User> save({required User user}) {
    return userDatasource.save(user: user);
  }

}