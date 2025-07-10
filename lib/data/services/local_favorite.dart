part of 'services.dart';

class LocalFavoriteDbHelper {
  static final LocalFavoriteDbHelper _instance =
      LocalFavoriteDbHelper._internal();
  Database? _database;

  LocalFavoriteDbHelper._internal();
  factory LocalFavoriteDbHelper() => _instance;

  Future<Database> get database async {
    return _database ??= await _initDb();
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorite.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE favorites(
          id TEXT PRIMARY KEY,
          name TEXT,
          city TEXT,
          pictureId TEXT,
          rating REAL
        )
      ''');
      },
    );
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      'favorites',
      restaurant.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return maps.map((map) => RestaurantDbExtension.fromDbMap(map)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
