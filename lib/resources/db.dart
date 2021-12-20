import 'dart:ffi';

import 'package:match_mates/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }
  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblprofile = 'profile';
  static const String _tblfriends = 'friends';

  //init db for first time
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/user.db', onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_tblprofile (
        iduser INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT ,
            uid TEXT,
            imagelinks TEXT,
            friends TEXT
            )
      ''');
      await db.execute('''
      CREATE TABLE $_tblfriends (
        idfriends INTEGER PRIMARY KEY AUTOINCREMENT,
            nameid TEXT ,
            tuneid TEXT,
            imagelinks TEXT,
            name TEXT
            )
      ''');
    }, version: 1);
    return db;
  }

  //checkng database exist or not
  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

//insert userprofile to database
  Future<void> insertUser(User user) async {
    final db = await database;
    await db?.insert(_tblfriends, user.toDb());
  }

  //insert friend to database
  Future<void> insertFriend(Friend user) async {
    final db = await database;
    await db?.insert(_tblfriends, user.toJson());
  }

  //look up  list from database
  Future<List<Friend>> getListFriend() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblfriends);
    return result.map((e) => Friend.fromJson(e)).toList();
  }

  //get user profile
  Future<List<User>> getUserProfile() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblprofile);
    return result.map((e) => User.fromJson(e)).toList();
  }

  //remove userprofile from database with id
  Future<void> removeUser(String id) async {
    final db = await database;
    await db!.delete(
      _tblprofile,
      where: 'id =?',
      whereArgs: [id],
    );
  }

  Future<void> updateImg(String imglinks) async {
    final db = await database;
    await db!.update(_tblprofile, {'imglinks': imglinks},
        where: 'iduser = ?', whereArgs: [1]);
  }

  //remove Friends from database with id
  Future<void> removeFriends(String id) async {
    final db = await database;
    await db!.delete(
      _tblfriends,
      where: 'id =?',
      whereArgs: [id],
    );
  }

  Future<Map> boolCheck(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db!.query(_tblprofile, where: 'id=?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }
}
