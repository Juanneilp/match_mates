import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/user.dart';

class ListProfileProvider extends ChangeNotifier {
  final username;
  ListProfileProvider({required this.username}) {
    getUser();
  }
  final _firestore = FirebaseFirestore.instance;
  List<User>? _user;
  List<User> get user => _user ?? [];
  String? _massage;
  String get massage => _massage ?? "";
  Future<dynamic> getUser() async {
    var result = await _firestore.collection('users').get();
    if (result.docs.isNotEmpty) {
      notifyListeners();
      return _user = result.docs.map((e) => User.fromJson(e.data())).toList();
    } else {
      notifyListeners();
      return _massage = "No Data";
    }
  }
}
