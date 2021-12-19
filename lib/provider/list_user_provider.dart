import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/resources/enum.dart';

class ListProfileProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<User>? _user;
  List<User> get user => _user ?? [];
  String? _massage;
  String get massage => _massage ?? "";
  ResultState _state = ResultState.noData;
  ResultState get state => _state;
  Future<dynamic> getUser(String username) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      var result = await _firestore
          .collection('users')
          .where('name', isEqualTo: username)
          .get();
      print(username);
      print(result.docs.isNotEmpty);
      if (result.docs.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _user = result.docs.map((e) => User.fromJson(e.data())).toList();
        print(_user);
        return _user;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _massage = "No Data";
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _massage = "error in $error";
    }
  }
}
