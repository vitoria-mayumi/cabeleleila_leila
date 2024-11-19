import 'package:cabeleileila/core/model/users/users_model.dart';
import 'package:cabeleileila/service/firestore/users/users_service.dart';
import 'package:flutter/material.dart';

abstract class LogonState {}

class InitLogonState extends LogonState {}

class LoadingLogonState extends LogonState {}

class ErrorLogonState extends LogonState {}

class SuccessLogonState extends LogonState {}

class LogonController extends ValueNotifier<LogonState> {
  LogonController() : super(InitLogonState());

  Future<void> logon(String name, String contactNumber, String userName, String password) async {
    value = LoadingLogonState();

    try {
      UsersService usersService = UsersService();

      final lastId = await usersService.getLastId();

      Users users = Users(
        id: lastId! + 1,
        name: name,
        contactNumber: contactNumber,
        userName: userName,
        password: password,
        userType: "user",
      );

      usersService.addUsers(users);
      value = SuccessLogonState();
    } catch (e) {
      value = ErrorLogonState();
    }
  }
}
