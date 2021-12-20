import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<File> selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png'],
  );
  File file = File(result!.files.single.path!);
  return file;
}

Future<dynamic> uploadFile(File? file) async {
  if (file == null) return;
  final filename = basename(file.path);
  final destination = "files/$filename";
  var task = FirebaseApi.uploadFile(destination, file);
  final snapshot = await task!.whenComplete(() {});
  final url = await snapshot.ref.getDownloadURL();
  return url;
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
