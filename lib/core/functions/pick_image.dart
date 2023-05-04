import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'crop_image.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  try {
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: source);
    if (file != null) {
      final croppedFile = await cropImage(file);
      if (croppedFile != null) {
        return await croppedFile.readAsBytes();
      }
    }
  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
  return null;
}
