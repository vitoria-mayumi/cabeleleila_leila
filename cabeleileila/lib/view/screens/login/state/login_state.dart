// ignore_for_file: use_build_context_synchronously

import 'package:cabeleileila/service/users/users_service.dart';
import 'package:cabeleileila/view/screens/logon/presentation/logon_screen.dart';
import 'package:cabeleileila/view/screens/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';

abstract class LoginState {}

class InitLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {}

class LoginController extends ValueNotifier<LoginState> {
  LoginController() : super(InitLoginState());

  Future<void> login(
      String userName, String password, BuildContext context) async {
    value = LoadingLoginState();

    try {
      UsersService usersService = UsersService();

      bool authenticated =
          await usersService.userAuthentication(userName, password);

      if (authenticated) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainScreen()));
      }
    } catch (e) {
      value = ErrorLoginState();
    }
  }

  logon(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LogonScreen();
    }));
  }
}
