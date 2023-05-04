import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> cropImage(XFile file) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );
  if (croppedFile == null) return null;
  return XFile(croppedFile.path);
}
