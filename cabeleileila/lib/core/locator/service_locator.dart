import 'package:cabeleileila/modules/login/data/datasources/sqlite_datasource.dart';
import 'package:cabeleileila/modules/login/data/repositories/user_repository_impl.dart';
import 'package:cabeleileila/modules/login/domain/repositories/user_repository.dart';
import 'package:cabeleileila/modules/login/domain/usecases/login_user.dart';
import 'package:cabeleileila/modules/login/domain/usecases/register_user.dart';
import 'package:cabeleileila/modules/scheduling/data/repositories/scheduling_repository_impl.dart';
import 'package:cabeleileila/modules/scheduling/domain/repositories/scheduling_repository.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/create_scheduling_usecase.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/delete_scheduling_usecase.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/get_scheduling_usecase.dart';
import 'package:cabeleileila/modules/scheduling/domain/usecases/update_scheduling_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<SQLiteDatasource>(() => SQLiteDatasource());

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl()));

  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));

  sl.registerLazySingleton<SchedulingRepository>(
    () => SchedulingRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetScheduling>(
    () => GetScheduling(sl()),
  );

  sl.registerLazySingleton<CreateScheduling>(
    () => CreateScheduling(sl()),
  );

  sl.registerLazySingleton<UpdateScheduling>(
    () => UpdateScheduling(sl()),
  );

  sl.registerLazySingleton<DeleteScheduling>(
    () => DeleteScheduling(sl()),
  );

  sl.registerSingletonAsync<Database>(() async {
    final datasource = sl<SQLiteDatasource>();
    return await datasource.database;
  });
}
