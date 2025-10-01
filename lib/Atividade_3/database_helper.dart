import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE users (
        id $idType,
        nome $textType,
        email $textType UNIQUE,
        senha $textType
      )
    ''');
  }

  // Função para inserir usuário (nome mais comum: insertUser)
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  // Função para buscar usuário por email e senha (login)
  Future<Map<String, dynamic>?> getUserByEmailAndSenha(String email, String senha) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

    // Retorna todos os usuários
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  // Deleta usuário pelo id
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
