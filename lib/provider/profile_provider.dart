import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/user.dart';

class ProfileProvider extends ChangeNotifier {
  final username;
  ProfileProvider({required this.username}) {
    getUser();
  }
  final _firestore = FirebaseFirestore.instance;
  User? _user;
  User get user => _user ?? User(name: "", imagelinks: "", friends: []);
  String? _massage;
  String get massage => _massage ?? "";
  Future<dynamic> getUser() async {
    var result =
        await _firestore.collection('users').doc('LWVylaLc2LIq0MPFSREg').get();
    print(User.fromJson(result.data()!));
    if (result.data()!.isNotEmpty) {
      notifyListeners();
      return _user = User.fromJson(result.data()!);
    } else {
      notifyListeners();
      return _massage = "No Data";
    }
  }
}
