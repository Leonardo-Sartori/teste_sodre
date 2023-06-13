// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i3;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:teste_sodre/data/blocs/user/user_bloc.dart' as _i4;
import 'package:teste_sodre/data/datasources/user_datasource.dart' as _i5;
import 'package:teste_sodre/data/repositories/user_repository.dart' as _i6;
import 'package:teste_sodre/data/repositories/user_repository_impl.dart' as _i7;
import 'package:teste_sodre/injection/injection.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.HttpClient>(() => registerModule.http);
    gh.factory<_i4.UserBloc>(() => _i4.UserBloc());
    gh.factory<_i5.UserDatasource>(() => _i5.UserDatasource());
    gh.factory<_i6.UserRepository>(
        () => _i7.UserRepositoryImpl(userDatasource: gh<_i5.UserDatasource>()));
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
