import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa la base de datos
  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'chat_messages.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Crea la tabla de mensajes (y asegúrate de agregar el campo `image` para almacenar la ruta de la imagen)
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT,
        image TEXT
      )
    ''');
  }

  // Inserta un mensaje en la base de datos
  Future<void> insertMessage(String content, String imagePath) async {
    final db = await database;

    await db.insert(
      'messages',
      {'content': content, 'image': imagePath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtiene todos los mensajes de la base de datos
  Future<List<Map<String, dynamic>>> getMessages() async {
    final db = await database;

    return await db.query('messages');
  }
}
