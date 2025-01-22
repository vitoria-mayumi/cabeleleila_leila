import 'package:cabeleileila/core/colors/colors_system.dart';
import 'package:cabeleileila/core/enums/button_enums.dart';
import 'package:cabeleileila/core/enums/input_enums.dart';
import 'package:cabeleileila/core/widgets/button/presentation/button_widget.dart';
import 'package:cabeleileila/core/widgets/input/presentation/input_widget.dart';
import 'package:cabeleileila/modules/login/presentation/state/login_state.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController _controller;

  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                top(),
                title(),
                form(),
                buttonLogin(),
                Divider(),
                bottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget top() {
    return Center(
      child: Image.asset(
        'images/logo.png',
        width: 300,
        height: 300,
      ),
    );
  }

  Widget title() {
    return Text(
      "Insira suas credenciais para entrar",
      style: TextStyle(
        color: SystemColors.secondary,
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        InputWidget(
          label: "Usuário",
          inputType: InputType.string,
          controller: _controllerUserName,
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Senha",
          inputType: InputType.password,
          controller: _controllerPassword,
        ),
      ],
    );
  }

  Widget buttonLogin() {
    return ButtonWidget(
      text: "Entrar",
      styleType: ButtonStyleType.fill,
      color: ButtonColor.primary,
      startIcon: Icons.login,
      action: () => _controller.login(
        _controllerUserName.text,
        _controllerPassword.text,
        context,
      ),
    );
  }

  Widget bottom() {
    return Column(
      children: [
        Text(
          "Não possui cadastro em nosso app?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: SystemColors.secondary,
          ),
        ),
        SizedBox(height: 20),
        ButtonWidget(
          text: "Cadastrar-se",
          styleType: ButtonStyleType.outline,
          color: ButtonColor.primary,
          action: () => _controller.logon(context),
        )
      ],
    );
  }
}
