import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_sodre/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @factoryMethod
  HttpClient get http => HttpClient();

}