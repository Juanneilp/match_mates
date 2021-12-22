import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/user.dart';

class ProfileProvider extends ChangeNotifier {
  final String username;
  ProfileProvider({required this.username}) {
    getUser();
  }
  final _firestore = FirebaseFirestore.instance;
  User? _user;
  User get user =>
      _user ??
      User(
          name: "",
          uid: "",
          imagelinks: "",
          friends: [],
          bio: "",
          city: "",
          gender: "",
          talent: false,
          token: 0);
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
              }
            else
              {
                _massage = "error update",
              }
          },
        );
    getUser();
  }

  Future<dynamic> setBiouser(String bio) async {
    var result = _firestore.collection('users').doc(username);
    await result.get().then(
          (value) async => {
            if (value.exists)
              {
                result.update({'bio': bio}),
              }
            else
              {
                _massage = "error update",
                notifyListeners(),
              }
          },
        );
    getUser();
  }

  Future<dynamic> setCityuser(String city) async {
    var result = _firestore.collection('users').doc(username);
    await result.get().then(
          (value) async => {
            if (value.exists)
              {
                result.update({'city': city}),
              }
            else
              {
                _massage = "error update",
                notifyListeners(),
              }
          },
        );
    getUser();
  }

  Future<dynamic> setImgUser(String img) async {
    var result = _firestore.collection('users').doc(username);
    await result.get().then(
          (value) async => {
            if (value.exists)
              {
                result.update({'imagelinks': img}),
              }
            else
              {
                _massage = "error update",
                notifyListeners(),
              }
          },
        );
    getUser();
  }

  Future<String> connection(User recive, User profile) async {
    String tunelid = "";
    var friends = profile.friends;
    if (friends.isNotEmpty) {
      for (var element in friends) {
        if (element.nameid == recive.uid) {
          getUser();
          return tunelid = element.tunelid;
        }
      }
      tunelid = await _firestore.collection('massage').add({
        'chat': [],
        'reciver': recive.name,
        'sender': profile.name,
      }).then((value) => tunelid = value.id);
      await _firestore.collection('users').doc(recive.uid).update({
        'friends': FieldValue.arrayUnion([
          Friend(
                  nameid: profile.uid,
                  imagelinks: profile.imagelinks,
                  name: profile.name,
                  tunelid: tunelid)
              .toJson()
        ])
      });
      await _firestore.collection('users').doc(profile.uid).update({
        'friends': FieldValue.arrayUnion([
          Friend(
                  nameid: recive.uid,
                  imagelinks: recive.imagelinks,
                  name: recive.name,
                  tunelid: tunelid)
              .toJson()
        ])
      });
    } else if (tunelid == "") {
      tunelid = await _firestore.collection('massage').add({
        'chat': [],
        'reciver': recive.name,
        'sender': profile.name,
      }).then((value) => tunelid = value.id);
      await _firestore.collection('users').doc(recive.uid).update({
        'friends': FieldValue.arrayUnion([
          Friend(
                  nameid: profile.uid,
                  imagelinks: profile.imagelinks,
                  name: profile.name,
                  tunelid: tunelid)
              .toJson()
        ])
      });
      await _firestore.collection('users').doc(profile.uid).update({
        'friends': FieldValue.arrayUnion([
          Friend(
                  nameid: recive.uid,
                  imagelinks: recive.imagelinks,
                  name: recive.name,
                  tunelid: tunelid)
              .toJson()
        ])
      });
    }
    getUser();
    return tunelid;
  }
}
