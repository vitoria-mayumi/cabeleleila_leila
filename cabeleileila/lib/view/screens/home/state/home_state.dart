// ignore_for_file: use_build_context_synchronously
import 'package:cabeleileila/core/model/scheduling/scheduling_model.dart';
import 'package:cabeleileila/service/firestore/scheduling/scheduling_service.dart';
import 'package:flutter/material.dart';

abstract class HomeState {}

class InitHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {}

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(InitHomeState());

  ValueNotifier<List<Scheduling>> listScheduling = ValueNotifier<List<Scheduling>>([]);
  ValueNotifier<bool> isVisibleFilters = ValueNotifier<bool>(false);

  Future<List<Scheduling>?> fetchList() async {
    value = LoadingHomeState();

    try {
      SchedulingService schedulingService = SchedulingService();

      return await schedulingService.getAll();
    } catch (e) {
      value = ErrorHomeState();
    }
  }

  bool isTodayWithinTwoDays(DateTime selectedDate) {
    DateTime today = DateTime.now();

    int differenceInDays = today.difference(selectedDate).inDays.abs();

    return differenceInDays <= 2;
  }
}
