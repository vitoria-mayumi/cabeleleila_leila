import 'package:cabeleileila/core/model/scheduling/scheduling_model.dart';
import 'package:cabeleileila/service/firestore/scheduling/scheduling_service.dart';
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

  Future<void> editScheduling(String serviceType, String date, String hour, int id) async {
    value = LoadingEditSchedulingState();

    try {
      SchedulingService schedulingService = SchedulingService();

      Scheduling scheduling = Scheduling(
        id: id,
        serviceType: serviceType,
        userId: 1,
        dateTime: "$date, $hour",
        status: "Aguardando confirmação",
      );

      schedulingService.update(id.toString(), scheduling);
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
