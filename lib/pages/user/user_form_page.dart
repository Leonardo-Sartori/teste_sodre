import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sodre/data/blocs/user/user_bloc.dart';
import 'package:teste_sodre/data/blocs/user/user_event.dart';
import 'package:teste_sodre/data/blocs/user/user_state.dart';
import 'package:teste_sodre/data/models/user.dart';
import 'package:teste_sodre/injection/injection.dart';
import 'package:teste_sodre/pages/user/user_list_view.dart';
import 'package:teste_sodre/utils/easy_loading/easy_loading.dart';
import 'package:teste_sodre/utils/nav/nav.dart';
import 'package:teste_sodre/widgets/app_textfield.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({Key? key}) : super(key: key);

  @override
  UserFormPageState createState() => UserFormPageState();
}

class UserFormPageState extends State<UserFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tName = TextEditingController();
  final TextEditingController _tEmail = TextEditingController();
  final TextEditingController _tAge = TextEditingController();
  User user = User(id: 0, name: "", age: 0, email: '');
  final _userBloc = getIt.get<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userBloc,
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: AppBar(
        title: const Text("Novo Cliente"),
        leading: IconButton(onPressed: () => _goToListView(), icon: const Icon(Icons.arrow_back, size: 30,)),
        actions: [
          IconButton(
              onPressed: () => _save(),
              icon: const Icon(
                Icons.check_circle_outline_sharp,
                size: 30,
              ))
        ],
      ),
    );
  }

  Widget _body() {
    return BlocConsumer(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UserSavingState || state is UserLoadingState) {
          showLoading("Salvando ...");
        } else if (state is UserSavingSuccessState) {
          dismiss();
          push(context, const UserListView(), replace: true);
        } else if (state is UserErrorState) {
          dismiss();
          showError("Não foi possível realizar a operação");
        }
      },
      builder: (context, state) {
        if (state is UserErrorState) {
          return const Center(child: Text("Ocorreu um erro inesperado!"));
        }

        return SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    AppTextfield(
                      "Nome *",
                      TextCapitalization.characters,
                      controller: _tName,
                      required: true,
                      inputType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório *';
                        }
                        if (value.length < 3) {
                          return 'O nome deve ter ao menos 3 letras! *';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    AppTextfield(
                      "Email *",
                      TextCapitalization.none,
                      controller: _tEmail,
                      inputType: TextInputType.emailAddress,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (!value.contains("@") || !value.contains(".com")) {
                          return 'Email inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    AppTextfield(
                      "Idade *",
                      TextCapitalization.sentences,
                      readOnly: false,
                      inputType: TextInputType.phone,
                      controller: _tAge,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório *';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _goToListView() {
    push(context, const UserListView(), replace: true);
  }

  Future<void> _save() async {
    bool formOk = _formKey.currentState!.validate();

    if (!formOk) {
      return;
    }

    user.name = _tName.text;
    user.email = _tEmail.text;
    user.age = int.parse(_tAge.text);

    _userBloc.add(UserSavingEvent(user: user));
  }
}
