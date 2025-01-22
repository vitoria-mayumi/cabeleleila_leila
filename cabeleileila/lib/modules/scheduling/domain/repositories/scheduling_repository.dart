import 'package:cabeleileila/modules/login/domain/entities/user.dart';
import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';

abstract class SchedulingRepository {
  Future<List<Scheduling>> getSchedulings(User? user);
  Future<int> createScheduling(Scheduling scheduling);
  Future<void> updateScheduling(Scheduling scheduling);
  Future<void> deleteScheduling(int id);
}
