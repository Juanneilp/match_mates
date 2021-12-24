import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:match_mates/model/talent.dart';
import 'package:match_mates/model/talent_model.dart';
import 'package:match_mates/model/user.dart';

class UserService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  auth.User? getUser() {
    print(_firebaseAuth.currentUser!.uid);
    return _firebaseAuth.currentUser;
  }

  void createUser(String name, String bio, String gender, String city) async {
    final user = _firebaseAuth.currentUser;
    final userRef = _firestore.collection('users').doc(user!.uid);
    userRef.get().then(
          (value) async => {
            if (value.exists)
              {}
            else
              {
                await userRef.set(UserProfile(
                        sellers: [],
                        name: name,
                        imagelinks: "",
                        friends: [],
                        uid: user.uid,
                        bio: bio,
                        city: city,
                        gender: gender,
                        talent: false,
                        token: 1200)
                    .toJson()),
              }
          },
        );
  }

  Future<String> createConnectionModelTalent(
      TalentModel recive, UserProfile sender) async {
    late String id;
    await _firestore.collection('massage').add({
      'chat': [],
      'reciver': recive.name,
      'sender': sender.name,
    }).then((value) => id = value.id);
    await _firestore.collection('talent').doc(recive.uid).update({
      'customer': FieldValue.arrayUnion([
        Friend(
                nameid: sender.uid,
                imagelinks: sender.imagelinks,
                name: sender.name,
                tunelid: id)
            .toJson()
      ])
    });
    await _firestore.collection('users').doc(sender.uid).update({
      'sellers': FieldValue.arrayUnion([
        Sellers(
                price: recive.price,
                nameid: recive.uid,
                imagelinks: recive.url,
                name: recive.name,
                tunelid: id)
            .toJson()
      ])
    });
    return id;
  }

  Future<String> createConnectionTalent(
      Talent recive, UserProfile sender) async {
    late String tunelid;
    await _firestore.collection('massage').add({
      'chat': [],
      'reciver': recive.name,
      'sender': sender.name,
    }).then((value) => tunelid = value.id);
    await _firestore.collection('talent').doc(recive.uid).update({
      'customer': FieldValue.arrayUnion([
        Friend(
                nameid: sender.uid,
                imagelinks: sender.imagelinks,
                name: sender.name,
                tunelid: tunelid)
            .toJson()
      ])
    });
    await _firestore.collection('users').doc(sender.uid).update({
      'sellers': FieldValue.arrayUnion([
        Sellers(
                price: recive.price,
                nameid: recive.uid,
                imagelinks: recive.url,
                name: recive.name,
                tunelid: tunelid)
            .toJson()
      ])
    });
    return tunelid;
  }

  Future<String> createConnectionSellersTalent(
      Sellers recive, UserProfile sender) async {
    late String tunelid;
    await _firestore.collection('massage').add({
      'chat': [],
      'reciver': recive.name,
      'sender': sender.name,
    }).then((value) => tunelid = value.id);
    await _firestore.collection('talent').doc(recive.nameid).update({
      'customer': FieldValue.arrayUnion([
        Friend(
                nameid: sender.uid,
                imagelinks: sender.imagelinks,
                name: sender.name,
                tunelid: tunelid)
            .toJson()
      ])
    });
    await _firestore.collection('users').doc(sender.uid).update({
      'sellers': FieldValue.arrayUnion([
        Sellers(
                price: recive.price,
                nameid: recive.nameid,
                imagelinks: recive.imagelinks,
                name: recive.name,
                tunelid: tunelid)
            .toJson()
      ])
    });
    return tunelid;
  }
}
