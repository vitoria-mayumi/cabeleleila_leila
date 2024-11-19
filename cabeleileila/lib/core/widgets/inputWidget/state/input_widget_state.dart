// ignore_for_file: use_build_context_synchronously

import 'package:cabeleileila/core/model/scheduling/scheduling_model.dart';
import 'package:cabeleileila/service/firestore/scheduling/scheduling_service.dart';
import 'package:flutter/material.dart';

abstract class InputWidgetState {}

class InitInputWidgetState extends InputWidgetState {}

class InputWidgetController extends ValueNotifier<InputWidgetState> {
  InputWidgetController() : super(InitInputWidgetState());

  ValueNotifier<bool> isObscurePassword = ValueNotifier<bool>(false);
  ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<TimeOfDay> selectedTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  setObscurePassword(bool newValue) {
    isObscurePassword.value = newValue;
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      helpText: '',
    );

    if (picked != null) {
      selectedDate.value = picked;
      verifySameWeek(context, controller);
    }
  }

  Future<void> selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
      controller.text = '${selectedTime.value.hour}:${selectedTime.value.minute}';
    }
  }

  DateTime? getDateIfInSameWeek(DateTime date, DateTime selectedDate) {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    if (date.isAtSameMomentAs(startOfWeek) || date.isAtSameMomentAs(endOfWeek) || (date.isAfter(startOfWeek) && date.isBefore(endOfWeek))) {
      return date;
    }

    return null;
  }

  void verifySameWeek(BuildContext context, TextEditingController controller) async {
    SchedulingService service = SchedulingService();
    List<Scheduling> listData = await service.getAll();
    DateTime? dateInTheSameWeek;

    for (var data in listData) {
      List<String> dateTimeSeparate = data.dateTime.split(',').map((e) => e.trim()).toList();

      String date = dateTimeSeparate[0];

      List<String> parts = date.split('/');

      int month = int.parse(parts[1]);
      int day = int.parse(parts[0]);
      int year = int.parse(parts[2]);

      DateTime dateFormatted = DateTime(year, month, day);

      dateInTheSameWeek = getDateIfInSameWeek(dateFormatted, selectedDate.value);
    }

    if (dateInTheSameWeek != null) {
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Aviso"),
            content: Text("Já existe um horário marcado na mesma semana. Deseja agendar para o mesmo dia?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Não"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Sim"),
              ),
            ],
          );
        },
      );

      if (confirmed!) {
        controller.text = "${dateInTheSameWeek.day}/${dateInTheSameWeek.month}/${dateInTheSameWeek.year}";
      } else {
        controller.text = '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
      }

      return;
    }
    controller.text = '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
  }
}
