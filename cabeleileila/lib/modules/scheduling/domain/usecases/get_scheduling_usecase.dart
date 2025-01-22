import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/domain/repositories/scheduling_repository.dart';

class GetScheduling {
  final SchedulingRepository repository;

  GetScheduling(this.repository);

  Future<List<Scheduling>> call(int? userId) async {
    return await repository.getSchedulings(userId);
  }
}
