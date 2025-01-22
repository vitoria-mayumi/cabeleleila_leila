import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/domain/repositories/scheduling_repository.dart';

class CreateScheduling {
  final SchedulingRepository repository;

  CreateScheduling(this.repository);

  Future<int> call(Scheduling scheduling) async {
    return repository.createScheduling(scheduling);
  }
}
