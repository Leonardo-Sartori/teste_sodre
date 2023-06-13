import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:teste_sodre/data/models/user.dart';
import 'package:http/http.dart' as http;

@injectable
class UserDatasource {

  static const url = 'http://localhost:8080/users';

 UserDatasource();

  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body);

    return responseData.map<User>((map) => User.fromMap(map)).toList();
  }

  Future<User> save({required User user}) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(user.toMap())
    );

    User userBody;
    userBody = User.fromMap(jsonDecode(response.body));
    return userBody;
  }
}