import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_mates/model/talent_model.dart';

class EChatStreamProvider {
  Stream<List<TalentModel>> getEchatMember() {
    return FirebaseFirestore.instance
        .collection('e_chat')
        .snapshots()
        .map((contain) => contain.docs
            .map(
              (event) => TalentModel.fromJson(
                event.data(),
              ),
            )
            .toList());
  }

  Stream<List<TalentModel>> getEchatsortMember() {
    return FirebaseFirestore.instance
        .collection('e_chat')
        .orderBy('price')
        .snapshots()
        .map((contain) => contain.docs
            .map(
              (event) => TalentModel.fromJson(
                event.data(),
              ),
            )
            .toList());
  }

  Stream<List<TalentModel>> getEchatsortRatingMember() {
    return FirebaseFirestore.instance
        .collection('e_chat')
        .orderBy('rating')
        .snapshots()
        .map((contain) => contain.docs
            .map(
              (event) => TalentModel.fromJson(
                event.data(),
              ),
            )
            .toList());
  }
}
