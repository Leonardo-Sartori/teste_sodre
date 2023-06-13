
import 'package:teste_sodre/data/models/user.dart';

abstract class UserEvent {}

class UserInitialEvent extends UserEvent {
  UserInitialEvent();
}

class UserLoadingEvent extends UserEvent {
  UserLoadingEvent();
}

class UserSuccessEvent extends UserEvent {
  UserSuccessEvent();
}

class UserErrorEvent extends UserEvent {
  final String error;
  
  UserErrorEvent({required this.error});
}

class UserSavingEvent extends UserEvent {
  final User user;

  UserSavingEvent({required this.user});
}