import 'package:flutter/material.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/resources/db.dart';
import 'package:match_mates/resources/enum.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getListFriends();
    _getUser();
  }

  ResultState? _state;
  ResultState get state => _state ?? ResultState.noData;

  String _massage = "";
  String get massage => _massage;

  List<Friend>? _listFriend = [];
  List<Friend> get listUser => _listFriend ?? [];
  User? _user;
  User get user =>
      _user ?? User(name: "", age: "", uid: "", imagelinks: "", friends: []);

  //getting list friends from first time
  void _getListFriends() async {
    final result = await databaseHelper.getListFriend();
    if (result.isEmpty) {
      _state = ResultState.noData;
      _massage = "No data";
      notifyListeners();
    } else {
      _state = ResultState.hasData;
      _listFriend = result;
      notifyListeners();
    }
  }

  void _getUser() async {
    final result = await databaseHelper.getUserProfile();
    if (result.isEmpty) {
      _state = ResultState.noData;
      _massage = "No data";
      notifyListeners();
    } else {
      _state = ResultState.hasData;
      _user = result.first;
      notifyListeners();
    }
  }

  //insert provider and connected to dbHelper
  void insertFriend(Friend user) async {
    databaseHelper.insertFriend(user);
    _getListFriends();
  }

  void insertProfile(User user) async {
    databaseHelper.insertUser(user);
    _getUser();
  }

  //delete provider and connected to dbHelper
  void deleteUser(String id) async {
    databaseHelper.removeUser(id);
    _getUser();
  }

  void delete(String id) async {
    databaseHelper.removeFriends(id);
    _getListFriends();
  }

  //checking db if the id already in the database
  Future<bool> isFavourite(String id) async {
    final boolCheck = await databaseHelper.boolCheck(id);
    return boolCheck.isNotEmpty;
  }
}
