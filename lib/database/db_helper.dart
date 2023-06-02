import 'dart:async';

import 'package:food_delivery_app_ui/database/db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'cart_database.db';
  static const _databaseVersion = 1;
  static const table = 'Cart';
  static const columnId = 'id';
  static const columnPrice = 'price';
  static const columnFood = 'food';
  static const columnQuantity = 'quantity';
  static const columnRestaurant = 'restaurant';
  static const columnDate = 'date';
  static const columnimageURL = 'imageURL';

  DatabaseHelper();

  static final DatabaseHelper db_instance = DatabaseHelper();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnPrice REAL NOT NULL, "
        "$columnFood TEXT NOT NULL, "
        "$columnQuantity INTEGER NOT NULL, "
        "$columnRestaurant TEXT NOT NULL, "
        "$columnimageURL TEXT NOT NULL, "
        "$columnDate TEXT NOT NULL)");
  }

  Future<Carts> insert(Carts carts) async {
    final db = await database;
    await db.insert(
      table,
      carts.toMap(),
    );
    return carts;
  }

  Future<List<Carts>> getCarts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Carts(
          id: maps[i]['id'],
          date: maps[i]['date'],
          price: maps[i]['price'],
          food: maps[i]['food'],
          quantity: maps[i]['quantity'],
          restaurant: maps[i]['restaurant'],
          imageURL: maps[i]['imageURL']);
    });
  }

  Future<int> update(Carts carts) async {
    final db = await database;
    return await db.update(
      table,
      carts.toMap(),
      where: '$columnId = ?',
      whereArgs: [carts.id],
    );
  }

  Future<int?> delete(int id) async {
    final db = await database;

    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var db = await database;
    db.close();
  }
}
