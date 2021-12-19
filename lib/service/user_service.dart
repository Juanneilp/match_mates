import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:match_mates/model/user.dart';
import 'package:match_mates/resources/db.dart';

class UserService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  auth.User? getUser() {
    return _firebaseAuth.currentUser;
  }

  void createUser(String age) async {
    final user = _firebaseAuth.currentUser;
    final userRef = _firestore.collection('users').doc(user!.uid);
    userRef.get().then((value) async => {
          if (value.exists)
            {print('exist')}
          else
            {
              await userRef.set(User(
                      age: age,
                      name: user.email ?? "",
                      imagelinks: "",
                      friends: [],
                      uid: user.uid)
                  .toJson()),
              await DatabaseHelper().insertUser(User(
                  age: age,
                  name: user.email ?? "",
                  imagelinks: "",
                  friends: [],
                  uid: user.uid))
            }
        });
  }

  Future<String> createConnection(User recive, String sender) async {
    late String id;
    await _firestore.collection('massage').add({
      'chat': [],
      'reciver': recive.name,
      'sender': sender,
    }).then((value) => id = value.id);
    await _firestore.collection('users').doc(recive.uid).update({
      'friends': FieldValue.arrayUnion([
        Friend(nameid: sender, imagelinks: "", name: sender, tunelid: id)
            .toJson()
      ])
    });
    await _firestore.collection('users').doc(sender).update({
      'friends': FieldValue.arrayUnion([
        Friend(
                nameid: recive.uid,
                imagelinks: "",
                name: recive.name,
                tunelid: id)
            .toJson()
      ])
    });
    await DatabaseHelper().insertFriend(Friend(
        nameid: recive.uid, imagelinks: "", name: recive.name, tunelid: id));
    return id;
  }
}
