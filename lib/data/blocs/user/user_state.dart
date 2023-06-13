import 'package:teste_sodre/data/models/user.dart';

abstract class UserState {
  List<User> userList = <User>[];
  User? user;

  UserState({
    required this.userList,
    this.user,
  });
}

class UserInitialState extends UserState {
  UserInitialState() : super(userList: []);
}

class UserLoadingState extends UserState {
  UserLoadingState({required List<User> userList}) : super(userList: userList);
}
class UserSuccessState extends UserState {
  UserSuccessState({required List<User> userList}) : super(userList: userList);
}

class UserErrorState extends UserState {
  UserErrorState({required String error}) : super(userList: []);
}

class UserSavingState extends UserState {
  UserSavingState({required User user}) : super(userList: [], user: user);
}

class UserSavingSuccessState extends UserState {
  UserSavingSuccessState({required List<User> userList, required User user}) : super(userList: [], user: user);
}