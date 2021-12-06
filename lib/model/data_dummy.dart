//just for testing it will be deleted when the rea data is ready
import 'package:cloud_firestore/cloud_firestore.dart';

class TextChat {
  String user;
  String chatString;
  Timestamp date;
  TextChat({required this.chatString, required this.user, required this.date});
}
