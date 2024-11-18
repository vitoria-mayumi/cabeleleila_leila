import 'package:cabeleileila/constants/colors/colors_constants.dart';
import 'package:cabeleileila/constants/enums/button_enums.dart';
import 'package:cabeleileila/constants/enums/input_enums.dart';
import 'package:cabeleileila/view/screens/logon/state/logon_state.dart';
import 'package:cabeleileila/view/widgets/buttonWidget/presentation/button_widget.dart';
import 'package:cabeleileila/view/widgets/inputWidget/presentation/input_widget.dart';
import 'package:flutter/material.dart';

class LogonScreen extends StatefulWidget {
  const LogonScreen({super.key});

  @override
  State<LogonScreen> createState() => _LogonScreenState();
}

class _LogonScreenState extends State<LogonScreen> {
  late LogonController _controller;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerContactNumber =
      TextEditingController();
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = LogonController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          if (value is ErrorLogonState) {}
          if (value is LoadingLogonState) {}
          if (value is SuccessLogonState) {}
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _title(),
                    _form(),
                    _buttonLogon(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cadastre-se",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: SystemColors.primary,
          ),
        ),
        Text(
          "Preencha os campos e cadastre-se em nosso app.",
          style: TextStyle(
            fontSize: 14,
            color: SystemColors.secondary,
          ),
        )
      ],
    );
  }

  Widget _form() {
    return Column(
      children: [
        InputWidget(
          label: "Nome*",
          inputType: InputType.string,
          placeholder: "Digite seu nome",
          controller: _controllerName,
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Telefone*",
          inputType: InputType.number,
          placeholder: "(00)00000-0000",
          controller: _controllerContactNumber,
        ),
        SizedBox(height: 20),
        Divider(),
        SizedBox(height: 20),
        _information(),
        SizedBox(height: 20),
        InputWidget(
          label: "Usuário*",
          inputType: InputType.string,
          placeholder: "Digite um nome de usuário",
          controller: _controllerUserName,
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Senha*",
          inputType: InputType.password,
          placeholder: "Digite uma senha",
          controller: _controllerPassword,
        ),
      ],
    );
  }

  Widget _information() {
    return Text(
      "Lembre-se de guardar seu usuário e senha, pois será usado para entrar no app.",
      style: TextStyle(
        fontSize: 14,
        color: SystemColors.secondary,
      ),
    );
  }

  Widget _buttonLogon() {
    return ButtonWidget(
      text: "Cadastrar",
      styleType: ButtonStyleType.fill,
      color: ButtonColor.primary,
      action: () => _controller.logon(
        _controllerName.text,
        _controllerContactNumber.text,
        _controllerUserName.text,
        _controllerPassword.text,
      ),
    );
  }
}
