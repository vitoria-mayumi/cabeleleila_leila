import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDatasource {
  static final SQLiteDatasource _instance = SQLiteDatasource._();
  static Database? _database;

  SQLiteDatasource._();

  factory SQLiteDatasource() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'app.db'),
      onCreate: _createDB,
      version: 1,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contactNumber TEXT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        userType TEXT NOT NULL
    )
    ''');

    await db.execute('''
      CREATE TABLE Scheduling (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        serviceType TEXT NOT NULL,
        status TEXT NOT NULL,
        dateHour TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES Users (id)
      )
    ''');
  }
}
