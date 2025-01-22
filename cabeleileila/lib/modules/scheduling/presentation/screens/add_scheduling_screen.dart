// ignore_for_file: use_build_context_synchronously

import 'package:cabeleileila/core/colors/colors_system.dart';
import 'package:cabeleileila/core/enums/button_enums.dart';
import 'package:cabeleileila/core/enums/input_enums.dart';
import 'package:cabeleileila/core/widgets/button/presentation/button_widget.dart';
import 'package:cabeleileila/core/widgets/input/presentation/input_widget.dart';
import 'package:cabeleileila/modules/scheduling/presentation/state/add_scheduling_state.dart';
import 'package:flutter/material.dart';

class AddSchedulingScreen extends StatefulWidget {
  const AddSchedulingScreen({super.key});

  @override
  State<AddSchedulingScreen> createState() => _AddSchedulingScreenState();
}

class _AddSchedulingScreenState extends State<AddSchedulingScreen> {
  late AddSchedulingController _controller;

  final TextEditingController _controllerServiceType = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerHour = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AddSchedulingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _title(),
                _form(),
                _buttonAdd(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Novo agendamento",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: SystemColors.primary,
          ),
        ),
        Text(
          "Preencha os campos para realizar seu agendamento.",
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputWidget(
          label: "Selecione o serviço desejado:",
          inputType: InputType.select,
          controller: _controllerServiceType,
          itemsSelector: [
            'Corte',
            'Tratamento',
            'Manicure',
            'Maquiagem'
          ],
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Selecione a melhor data para você:",
          inputType: InputType.date,
          controller: _controllerDate,
          verifySameWeek: true,
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Selecione o melhor horário para ser atendido:",
          inputType: InputType.hour,
          controller: _controllerHour,
        ),
      ],
    );
  }

  Widget _buttonAdd() {
    return ButtonWidget(
      text: "Realizar agendamento",
      styleType: ButtonStyleType.fill,
      color: ButtonColor.primary,
      startIcon: Icons.check_circle_outline,
      action: () async {
        _controller
            .addScheduling(
          _controllerServiceType.text,
          _controllerDate.text,
          _controllerHour.text,
        )
            .whenComplete(() {
          Navigator.pop(context, true);
        });
      },
    );
  }
}
