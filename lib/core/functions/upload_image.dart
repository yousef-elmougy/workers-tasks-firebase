import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(Uint8List file, String storagePath) async {
  final taskSnapshot =
      await FirebaseStorage.instance.ref().child(storagePath).putData(file);
  return taskSnapshot.ref.getDownloadURL();
}
