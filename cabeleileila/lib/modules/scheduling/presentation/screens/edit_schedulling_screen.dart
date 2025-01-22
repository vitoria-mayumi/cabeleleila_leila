// ignore_for_file: use_build_context_synchronously

import 'package:cabeleileila/core/colors/colors_system.dart';
import 'package:cabeleileila/core/enums/button_enums.dart';
import 'package:cabeleileila/core/enums/input_enums.dart';
import 'package:cabeleileila/core/widgets/button/presentation/button_widget.dart';
import 'package:cabeleileila/core/widgets/input/presentation/input_widget.dart';
import 'package:cabeleileila/modules/scheduling/presentation/state/edit_scheduling_state.dart';
import 'package:flutter/material.dart';

class EditSchedulingScreen extends StatefulWidget {
  final String serviceType;
  final String dateTime;
  final int id;

  const EditSchedulingScreen({
    super.key,
    required this.serviceType,
    required this.dateTime,
    required this.id,
  });

  @override
  State<EditSchedulingScreen> createState() => _EditSchedulingScreenState();
}

class _EditSchedulingScreenState extends State<EditSchedulingScreen> {
  late EditSchedulingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditSchedulingController();
    _controller.initState(widget.dateTime, widget.serviceType);
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
                _buttonEdit(),
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
          "Editar agendamento",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: SystemColors.primary,
          ),
        ),
        Text(
          "Preencha os campos para editar seu agendamento.",
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
          label: "Serviço:",
          inputType: InputType.select,
          controller: _controller.controllerServiceType,
          itemsSelector: [
            'Corte',
            'Tratamento',
            'Manicure',
            'Maquiagem'
          ],
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Data:",
          inputType: InputType.date,
          controller: _controller.controllerDate,
        ),
        SizedBox(height: 20),
        InputWidget(
          label: "Hora:",
          inputType: InputType.hour,
          controller: _controller.controllerHour,
        ),
      ],
    );
  }

  Widget _buttonEdit() {
    return ButtonWidget(
      text: "Editar",
      styleType: ButtonStyleType.fill,
      color: ButtonColor.primary,
      startIcon: Icons.check_circle_outline,
      action: () async {
        _controller
            .editScheduling(
          _controller.controllerServiceType.text,
          _controller.controllerDate.text,
          _controller.controllerHour.text,
          "Aguardando confirmação",
          widget.id,
        )
            .whenComplete(() {
          Navigator.pop(context, true);
        });
      },
    );
  }
}
