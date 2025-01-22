import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';

abstract class SchedulingRepository {
  Future<List<Scheduling>> getSchedulings(int? userId);
  Future<int> createScheduling(Scheduling scheduling);
  Future<void> updateScheduling(Scheduling scheduling);
  Future<void> deleteScheduling(int id);
}
