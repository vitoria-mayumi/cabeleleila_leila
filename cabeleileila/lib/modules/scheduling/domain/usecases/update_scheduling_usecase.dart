import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/domain/repositories/scheduling_repository.dart';

class UpdateScheduling {
  final SchedulingRepository repository;

  UpdateScheduling(this.repository);

  Future<void> call(Scheduling scheduling) async {
    await repository.updateScheduling(scheduling);
  }
}
