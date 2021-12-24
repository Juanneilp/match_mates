import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/model/hangout_model.dart';
import 'package:match_mates/resources/enum.dart';

class HangoutNotifyProvider extends ChangeNotifier {
  HangoutNotifyProvider() {
    getUser();
  }

  void updateByRating() {
    getUserByRating();
  }

  void updateByPrice() {
    getUserByRating();
  }

  final _firestore = FirebaseFirestore.instance;
  List<HangoutModel>? _model;
  List<HangoutModel> get model => _model ?? [];
  String? _massage;
  String get massage => _massage ?? "";
  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  Future<dynamic> getUser() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      var result = await _firestore.collection('hangoutt').get();
      if (result.docs.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _model =
            result.docs.map((e) => HangoutModel.fromJson(e.data())).toList();
        return _model;
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

  Future<dynamic> getUserByRating() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      var result = await _firestore
          .collection('hangoutt')
          .orderBy('rating', descending: true)
          .get();
      if (result.docs.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _model =
            result.docs.map((e) => HangoutModel.fromJson(e.data())).toList();
        return _model;
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

  Future<dynamic> getUserByPrice() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      var result = await _firestore
          .collection('hangoutt')
          .orderBy('price', descending: false)
          .get();
      if (result.docs.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _model =
            result.docs.map((e) => HangoutModel.fromJson(e.data())).toList();
        return _model;
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
