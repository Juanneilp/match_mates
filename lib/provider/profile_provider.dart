import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/talent.dart';
import 'package:match_mates/model/talent_model.dart';
import 'package:match_mates/model/tokeclass.dart';
import 'package:match_mates/model/user.dart';
import 'package:match_mates/service/user_service.dart';

class ProfileProvider extends ChangeNotifier {
  final String username;
  ProfileProvider({required this.username}) {
    getUser();
  }
  final _firestore = FirebaseFirestore.instance;
  UserProfile? _user;
  UserProfile get user =>
      _user ??
      UserProfile(
          sellers: [],
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
      return _user = UserProfile.fromJson(result.data()!);
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

  Future<String> talentConnection(Talent recive, UserProfile profile) async {
    String tunelid = "";
    var sellers = profile.sellers;
    if (sellers.isNotEmpty) {
      for (var element in sellers) {
        if (element.nameid == recive.uid) {
          getUser();
          return tunelid = element.tunelid;
        }
      }
      tunelid = await UserService().createConnectionTalent(recive, profile);
    } else if (tunelid == "") {
      tunelid = await UserService().createConnectionTalent(recive, profile);
    }
    getUser();
    return tunelid;
  }

  Future<String> talentModelConnection(
      TalentModel recive, UserProfile profile) async {
    String tunelid = "";
    var sellers = profile.sellers;
    if (sellers.isNotEmpty) {
      for (var element in sellers) {
        if (element.nameid == recive.uid) {
          getUser();
          return tunelid = element.tunelid;
        }
      }
      tunelid =
          await UserService().createConnectionModelTalent(recive, profile);
    } else if (tunelid == "") {
      tunelid =
          await UserService().createConnectionModelTalent(recive, profile);
    }
    getUser();
    return tunelid;
  }

  Future<String> sellersConnection(Sellers recive, UserProfile profile) async {
    String tunelid = "";
    var sellers = profile.sellers;
    if (sellers.isNotEmpty) {
      for (var element in sellers) {
        if (element.nameid == recive.nameid) {
          getUser();
          return tunelid = element.tunelid;
        }
      }
      tunelid =
          await UserService().createConnectionSellersTalent(recive, profile);
    } else if (tunelid == "") {
      tunelid =
          await UserService().createConnectionSellersTalent(recive, profile);
    }
    getUser();
    return tunelid;
  }

  Future<dynamic> createTransaction(
      String recive, String sender, int value) async {
    var sellers = _firestore.collection('talent').doc(recive);
    var user = _firestore.collection('users').doc(sender);
    await _firestore.collection('transaction').add({
      'sellersuid': recive,
      'senderuid': sender,
      'value': value,
    });
    await sellers.update({
      'token': FieldValue.increment(value),
    });
    await user.update(
      {'token': FieldValue.increment(-(value - value * 0.1))},
    );
    getUser();
  }

  Future<String?> getPoints(String codetoken, String user) async {
    try {
      var amount =
          await _firestore.collection('tokencode').doc(codetoken).get();
      int value = TokenClass.fromJson(amount.data()!).amount;
      await _firestore.collection('users').doc(user).update({
        'token': FieldValue.increment(value),
      }).then((value) async => {
            await _firestore.collection('tokencode').doc(codetoken).delete(),
          });
      getUser();
      return _massage = "Succes";
    } catch (e) {
      _massage = "error Redeem";
      notifyListeners();
      return _massage;
    }
  }
}
