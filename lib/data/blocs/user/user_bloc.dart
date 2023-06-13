import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_sodre/data/blocs/user/user_event.dart';
import 'package:teste_sodre/data/blocs/user/user_state.dart';
import 'package:teste_sodre/data/models/user.dart';
import 'package:teste_sodre/data/repositories/user_repository.dart';
import 'package:teste_sodre/injection/injection.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = getIt.get<UserRepository>();
  
  UserBloc() : super(UserInitialState()) {    
    on<UserLoadingEvent>((ev, emit) async {
      emit(UserLoadingState(userList: []));

      try {
        final userList = await _fetchUserList();
        emit(UserSuccessState(userList: userList));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });

    on<UserSavingEvent>((ev, emit) async {
      final User user;

      emit(UserLoadingState(userList: []));

      try {
        user = await userRepository.save(user: ev.user);
        emit(UserSavingSuccessState(userList: [], user: user));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });
  }

  Future<List<User>> _fetchUserList() async {
    List<User> users = <User>[];

    try {
      users = await userRepository.getAllUsers();
      return users;
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar usuários!');
    }
  }
}