import 'package:flutter/material.dart';

abstract class InputWidgetState {}

class InitInputWidgetState extends InputWidgetState {}

class InputWidgetController extends ValueNotifier<InputWidgetState> {
  InputWidgetController() : super(InitInputWidgetState());

  ValueNotifier<bool> isObscurePassword = ValueNotifier<bool>(false);

  setObscurePassword(bool newValue) {
    isObscurePassword.value = newValue;
  }
}
