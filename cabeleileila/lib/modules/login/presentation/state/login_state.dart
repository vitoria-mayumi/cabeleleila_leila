// ignore_for_file: use_build_context_synchronously

import 'package:cabeleileila/core/constants/global_variables.dart';
import 'package:cabeleileila/core/locator/service_locator.dart';
import 'package:cabeleileila/modules/login/domain/usecases/login_user.dart';
import 'package:cabeleileila/modules/login/presentation/screens/logon_screen.dart';
import 'package:cabeleileila/modules/scheduling/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

abstract class LoginState {}

class InitLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {}

class LoginController extends ValueNotifier<LoginState> {
  LoginController() : super(InitLoginState());

  final LoginUser loginUserUseCase = sl<LoginUser>();

  Future<void> login(String userName, String password, BuildContext context) async {
    value = LoadingLoginState();

    try {
      final result = await loginUserUseCase(userName, password);

      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário não encontrado!')),
        );

        return;
      }

      GlobalVariables().userId = result.id;

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao tentar fazer login!')),
      );
      value = ErrorLoginState();
    }
  }

  logon(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LogonScreen();
    }));
  }
}
