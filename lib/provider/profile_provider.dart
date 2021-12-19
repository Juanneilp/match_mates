import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/resources/db.dart';
import 'package:match_mates/service/user_service.dart';

class ProfileProvider extends ChangeNotifier {
  final String username;
  ProfileProvider({required this.username}) {
    getUser();
  }
  final _firestore = FirebaseFirestore.instance;
  User? _user;
  User get user =>
      _user ?? User(age: "", name: "", uid: "", imagelinks: "", friends: []);
  String? _massage;
  String get massage => _massage ?? "";
  Future<dynamic> getUser() async {
    var result = await _firestore.collection('users').doc(username).get();
    if (result.data()!.isNotEmpty) {
      notifyListeners();
      return _user = User.fromJson(result.data()!);
    } else {
      notifyListeners();
      return _massage = "No Data";
    }
  }

  Future<dynamic> setNameuser(String name) async {
    var result = _firestore.collection('users').doc(username);
    await result.get().then(
          (value) async => {
            if (value.exists)
              {
                result.update({'name': name}),
                notifyListeners(),
              }
            else
              {
                _massage = "error update",
                notifyListeners(),
              }
          },
        );
  }

  Future<dynamic> connection(User recive, String user) async {
    var profile = await _firestore.collection('massage').doc(user).get();
    late String tunelid;
    var friends = User.fromJson(profile.data()!).friends;
    print(friends.first.tunelid);
    print(user);
    friends.map((e) async => {
          if (e.nameid == recive.uid)
            {tunelid == e.tunelid}
          else
            {tunelid = await UserService().createConnection(recive, user)}
        });
    notifyListeners();
    return tunelid;
  }
}
