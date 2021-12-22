import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:match_mates/model/user.dart';

class UserService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  auth.User? getUser() {
    return _firebaseAuth.currentUser;
  }

  void createUser(String name, String bio, String gender, String city) async {
    final user = _firebaseAuth.currentUser;
    final userRef = _firestore.collection('users').doc(user!.uid);
    userRef.get().then((value) async => {
          if (value.exists)
            {}
          else
            {
              await userRef.set(User(
                      name: name,
                      imagelinks: "",
                      friends: [],
                      uid: user.uid,
                      bio: bio,
                      city: city,
                      gender: gender,
                      talent: false,
                      token: 0)
                  .toJson()),
            }
        });
  }

  Future<String> createConnection(User recive, User sender) async {
    late String id;
    await _firestore.collection('massage').add({
      'chat': [],
      'reciver': recive.name,
      'sender': sender.name,
    }).then((value) => id = value.id);
    await _firestore.collection('users').doc(recive.uid).update({
      'friends': FieldValue.arrayUnion([
        Friend(
                nameid: sender.uid,
                imagelinks: sender.imagelinks,
                name: sender.name,
                tunelid: id)
            .toJson()
      ])
    });
    await _firestore.collection('users').doc(sender.uid).update({
      'friends': FieldValue.arrayUnion([
        Friend(
                nameid: recive.uid,
                imagelinks: recive.imagelinks,
                name: recive.name,
                tunelid: id)
            .toJson()
      ])
    });
    return id;
  }
}
