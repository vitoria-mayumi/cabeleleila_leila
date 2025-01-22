// ignore_for_file: use_build_context_synchronously
import 'package:cabeleileila/core/constants/global_variables.dart';
import 'package:cabeleileila/core/locator/service_locator.dart';
import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/get_scheduling_usecase.dart';
import 'package:flutter/material.dart';

abstract class HomeState {}

class InitHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {}

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(InitHomeState());

  final GetScheduling getSchedulingUseCase = sl<GetScheduling>();

  ValueNotifier<List<Scheduling>> listScheduling = ValueNotifier<List<Scheduling>>([]);
  ValueNotifier<bool> isVisibleFilters = ValueNotifier<bool>(false);

  ValueNotifier<Future<List<Scheduling>>?> listData = ValueNotifier<Future<List<Scheduling>>?>(null);

  Future<List<Scheduling>?> fetchList() async {
    value = LoadingHomeState();

    try {
      listData.value = getSchedulingUseCase(GlobalVariables().userId);

      return listData.value;
    } catch (e) {
      value = ErrorHomeState();
    }
    return null;
  }

  bool isTodayWithinTwoDays(DateTime selectedDate) {
    DateTime today = DateTime.now();

    int differenceInDays = today.difference(selectedDate).inDays.abs();

    return differenceInDays <= 2;
  }
}
