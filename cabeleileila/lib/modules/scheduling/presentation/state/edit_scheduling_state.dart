import 'package:cabeleileila/core/constants/global_variables.dart';
import 'package:cabeleileila/core/locator/service_locator.dart';
import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/update_scheduling_usecase.dart';
import 'package:flutter/material.dart';

abstract class EditSchedulingState {}

class InitEditSchedulingState extends EditSchedulingState {}

class LoadingEditSchedulingState extends EditSchedulingState {}

class ErrorEditSchedulingState extends EditSchedulingState {}

class EditSchedulingController extends ValueNotifier<EditSchedulingState> {
  EditSchedulingController() : super(InitEditSchedulingState());

  final TextEditingController controllerServiceType = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  final TextEditingController controllerHour = TextEditingController();

  final UpdateScheduling updateSchedulingUseCase = sl<UpdateScheduling>();

  Future<void> editScheduling(String serviceType, String date, String hour, String status, int id) async {
    value = LoadingEditSchedulingState();

    try {
      Scheduling scheduling = Scheduling(
        id: id,
        serviceType: serviceType,
        status: status,
        idUser: GlobalVariables().userId!,
        dateHour: '$date, $hour',
      );

      updateSchedulingUseCase(scheduling);
    } catch (e) {
      value = ErrorEditSchedulingState();
    }
  }

  initState(String dateTime, String serviceType) {
    List<String> dateTimeSeparate = dateTime.split(',').map((e) => e.trim()).toList();

    String date = dateTimeSeparate[0];
    String hour = dateTimeSeparate[1];

    controllerServiceType.text = serviceType;
    controllerDate.text = date;
    controllerHour.text = hour;
  }
}
