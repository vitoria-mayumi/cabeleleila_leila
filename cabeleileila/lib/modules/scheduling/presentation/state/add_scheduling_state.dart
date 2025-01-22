import 'package:cabeleileila/core/constants/global_variables.dart';
import 'package:cabeleileila/core/locator/service_locator.dart';
import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/create_scheduling_usecase.dart';
import 'package:flutter/material.dart';

abstract class AddSchedulingState {}

class InitAddSchedulingState extends AddSchedulingState {}

class LoadingAddSchedulingState extends AddSchedulingState {}

class ErrorAddSchedulingState extends AddSchedulingState {}

class AddSchedulingController extends ValueNotifier<AddSchedulingState> {
  AddSchedulingController() : super(InitAddSchedulingState());

  final CreateScheduling createSchedulingUseCase = sl<CreateScheduling>();

  Future<void> addScheduling(String serviceType, String date, String hour) async {
    value = LoadingAddSchedulingState();

    try {
      Scheduling scheduling = Scheduling(
        serviceType: serviceType,
        status: "Aguardando confirmação",
        idUser: GlobalVariables().userId!,
        dateHour: '$date, $hour',
      );

      createSchedulingUseCase(scheduling);
    } catch (e) {
      value = ErrorAddSchedulingState();
    }
  }
}
