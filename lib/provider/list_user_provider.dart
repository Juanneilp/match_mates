import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_mates/model/talent.dart';
import 'package:match_mates/resources/enum.dart';

class ListProfileProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<Talent>? _user;
  List<Talent> get user => _user ?? [];
  String? _massage;
  String get massage => _massage ?? "";
  ResultState _state = ResultState.noData;
  ResultState get state => _state;
  Future<dynamic> getUser(String username) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      var result = await _firestore
          .collection('talent')
          .where('name', isGreaterThanOrEqualTo: username)
          .get();
      if (result.docs.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _user = result.docs.map((e) => Talent.fromJson(e.data())).toList();
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
