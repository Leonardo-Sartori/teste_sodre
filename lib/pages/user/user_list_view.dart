import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sodre/data/blocs/user/user_bloc.dart';
import 'package:teste_sodre/data/blocs/user/user_event.dart';
import 'package:teste_sodre/data/blocs/user/user_state.dart';
import 'package:teste_sodre/data/models/user.dart';
import 'package:teste_sodre/injection/injection.dart';
import 'package:teste_sodre/pages/user/user_form_page.dart';
import 'package:teste_sodre/pages/user/user_list_item.dart';
import 'package:teste_sodre/utils/nav/nav.dart';
import 'package:teste_sodre/widgets/app_nodata.dart';
import 'package:teste_sodre/widgets/custom_bottom_navigator_bar.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final _userBloc = getIt.get<UserBloc>();
  List<User> filteredUsers = <User>[];
  List<User> users = <User>[];
  int listLenght = 0;

  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getUsers() {
    _userBloc.add(UserLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
      ),
      body: BlocProvider(
        create: (context) => _userBloc,
        child: _body(),
      ),
      bottomNavigationBar: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is UserLoadingState || state is UserErrorState) {
            listLenght = 0;
          }

          if (state is UserSuccessState) {
            listLenght = state.userList.length;
          }
        },
        builder: (context, state) {
          if (state is UserSuccessState) {
            return CustomBottomNavigationBar(
              count: listLenght,
              text: 'Usuários',
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key("floating_button"),
        onPressed: () => _goToForm(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _body() {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserSuccessState) {
          users = state.userList;
          filteredUsers = users;
          listLenght = state.userList.length;
        }

        if (state is UserSuccessState) {
          return filteredUsers.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= filteredUsers.length
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                UserListItem(
                                  user: filteredUsers[index],
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          );
                  },
                  itemCount: filteredUsers.length,
                )
              : const AppNoData();
        } else {
          return Container();
        }
      },
    );
  }

  void _goToForm() {
    push(
      context,
      const UserFormPage(),
      replace: true);
  }
}