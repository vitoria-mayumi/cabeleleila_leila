// ignore_for_file: use_build_context_synchronously

import 'package:cabeleileila/core/locator/service_locator.dart';
import 'package:cabeleileila/modules/login/domain/entities/user.dart';
import 'package:cabeleileila/modules/login/domain/usecases/register_user.dart';
import 'package:flutter/material.dart';

abstract class LogonState {}

class InitLogonState extends LogonState {}

class LoadingLogonState extends LogonState {}

class ErrorLogonState extends LogonState {}

class SuccessLogonState extends LogonState {}

class LogonController extends ValueNotifier<LogonState> {
  LogonController() : super(InitLogonState());

  final RegisterUser registerUserUseCase = sl<RegisterUser>();

  Future<void> logon(String name, String contactNumber, String userName, String password, BuildContext context) async {
    value = LoadingLogonState();

    try {
      User user = User(
        username: userName,
        password: password,
        userType: 'user',
        contactNumber: contactNumber,
        nickName: name,
      );

      await registerUserUseCase(user);

      value = SuccessLogonState();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao tentar cadastrar!')),
      );
      value = ErrorLogonState();
    }
  }
}
