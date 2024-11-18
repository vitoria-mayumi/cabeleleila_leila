import 'package:cabeleileila/constants/colors/colors_constants.dart';
import 'package:cabeleileila/constants/enums/button_enums.dart';
import 'package:cabeleileila/constants/enums/input_enums.dart';
import 'package:cabeleileila/view/widgets/buttonWidget/presentation/button_widget.dart';
import 'package:cabeleileila/view/widgets/inputWidget/presentation/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSchedulingScreen extends StatefulWidget {
  const AddSchedulingScreen({super.key});

  @override
  State<AddSchedulingScreen> createState() => _AddSchedulingScreenState();
}

class _AddSchedulingScreenState extends State<AddSchedulingScreen> {
  final TextEditingController _controllerCalendar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
              ),
              Text(
                "Selecione o tipo de serviço que deseja:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: SystemColors.secondary,
                ),
              ),
              DropdownButton<String>(
                items: <String>['Corte', 'Tratamento', 'Manicure', 'Maquiagem']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
              Text(
                "Selecione a melhor data para você:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: SystemColors.secondary,
                ),
              ),
              InputWidget(
                label: "",
                inputType: InputType.calendar,
                placeholder: "dd/mm/aaaa",
                controller: _controllerCalendar,
              ),
              Text(
                "Selecione o melhor horário para ser atendido:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: SystemColors.secondary,
                ),
              ),
              ButtonWidget(
                text: "Realizar agendamento",
                styleType: ButtonStyleType.fill,
                color: ButtonColor.primary,
                startIcon: Icons.check_circle_outline,
              )
            ],
          ),
        ),
      ),
    );
  }
}
