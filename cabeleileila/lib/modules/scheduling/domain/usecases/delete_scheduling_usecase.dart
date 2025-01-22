import 'package:cabeleileila/modules/scheduling/domain/repositories/scheduling_repository.dart';

class DeleteScheduling {
  final SchedulingRepository repository;

  DeleteScheduling(this.repository);

  Future<void> call(int id) async {
    await repository.deleteScheduling(id);
  }
}
