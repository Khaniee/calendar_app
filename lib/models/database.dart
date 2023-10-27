import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("database.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const boolType = "BOOLEAN NOT NULL";
    const integerType = "INTEGER NOT NULL";
    const nullableIntegerType = "INTEGER";
    const doubleType = "REAL NOT NULL";
    const blobType = "BLOB NOT NULL";

    // Create each table when creating database

    // await db.execute("""CREATE TABLE $tableStores(
    //   ${StoreFields.id} $idType,
    //   ${StoreFields.nom} $textType,
    //   ${StoreFields.contact} $textType,
    //   ${StoreFields.horairesOuverture1} $textType,
    //   ${StoreFields.horairesOuverture2} $textType,
    //   ${StoreFields.longlat} $textType,
    //   ${StoreFields.image} $blobType
    // )
    // """);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
