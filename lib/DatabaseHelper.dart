import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, "registro.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS estudiante(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, matricula TEXT)'
    );
  }
}