import 'package:cabeleileila/modules/login/data/datasources/sqlite_datasource.dart';
import 'package:cabeleileila/modules/login/domain/entities/user.dart';
import 'package:cabeleileila/modules/scheduling/data/models/scheduling_model.dart';

import '../../domain/entities/scheduling.dart';
import '../../domain/repositories/scheduling_repository.dart';

class SchedulingRepositoryImpl implements SchedulingRepository {
  final SQLiteDatasource datasource;

  SchedulingRepositoryImpl(this.datasource);

  @override
  Future<List<Scheduling>> getSchedulings(User? user) async {
    final db = await datasource.database;

    if (user!.userType == 'admin') {
      final result = await db.query('Scheduling');

      return result.map((map) => SchedulingModel.fromMap(map)).toList();
    }

    final result = await db.query(
      'Scheduling',
      where: 'userId = ?',
      whereArgs: [
        user.id
      ],
    );

    return result.map((map) => SchedulingModel.fromMap(map)).toList();
  }

  @override
  Future<int> createScheduling(Scheduling scheduling) async {
    final db = await datasource.database;

    return db.insert('Scheduling', {
      'userId': scheduling.idUser,
      'serviceType': scheduling.serviceType,
      'status': scheduling.status,
      'dateHour': scheduling.dateHour,
    });
  }

  @override
  Future<void> updateScheduling(Scheduling scheduling) async {
    final db = await datasource.database;
    await db.update(
      'Scheduling',
      {
        'id': scheduling.id,
        'userId': scheduling.idUser,
        'serviceType': scheduling.serviceType,
        'status': scheduling.status,
        'dateHour': scheduling.dateHour,
      },
      where: 'id = ?',
      whereArgs: [
        scheduling.id
      ],
    );
  }

  @override
  Future<void> deleteScheduling(int id) async {
    final db = await datasource.database;
    await db.delete(
      'Scheduling',
      where: 'id = ?',
      whereArgs: [
        id
      ],
    );
  }
}
