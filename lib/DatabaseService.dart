import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'FavoritePokemon.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();

    return _database!;
  }

  _initDb() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, 'favorites.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE favoritePokemons (id TEXT PRIMARY KEY, name TEXT, imageUrl TEXT)',
    );
  }

  Future<List<FavoritePokemon>> getFavoritePokemons() async {
    var db = await database;
    var result = await db.query('favoritePokemons');
    return result.map((e) => FavoritePokemon.fromJson(e)).toList();
  }

  Future addFavoritePokemon(FavoritePokemon pokemon) async {
    var db = await database;
    await db.insert('favoritePokemons', pokemon.toJson());
  }

  Future removeFavoritePokemon(String id) async {
    var db = await database;
    await db.delete('favoritePokemons', where: 'id = ?', whereArgs: [id]);
  }

  close() {
    _database?.close();
    _database = null;
  }
}
