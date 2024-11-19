import 'package:cabeleileila/core/model/scheduling/scheduling_model.dart';
import 'package:cabeleileila/service/firestore/scheduling/scheduling_service.dart';
import 'package:flutter/material.dart';

abstract class AddSchedulingState {}

class InitAddSchedulingState extends AddSchedulingState {}

class LoadingAddSchedulingState extends AddSchedulingState {}

class ErrorAddSchedulingState extends AddSchedulingState {}

class AddSchedulingController extends ValueNotifier<AddSchedulingState> {
  AddSchedulingController() : super(InitAddSchedulingState());

  Future<void> addScheduling(String serviceType, String date, String hour) async {
    value = LoadingAddSchedulingState();

    try {
      SchedulingService schedulingService = SchedulingService();

      final lastId = await schedulingService.getLastId();

      Scheduling scheduling = Scheduling(
        id: lastId! + 1,
        serviceType: serviceType,
        userId: 1,
        dateTime: "$date, $hour",
        status: "Aguardando confirmação",
      );

      schedulingService.add(scheduling);
    } catch (e) {
      value = ErrorAddSchedulingState();
    }
  }
}
