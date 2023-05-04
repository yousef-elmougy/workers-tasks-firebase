import '../../lib_exports.dart';

Future<void> selectImageDialog(
  BuildContext context, {
  required VoidCallback pickCameraImage,
  required VoidCallback pickGalleryImage,
}) async => await showDialog<void>(
    context: context,
    useRootNavigator: false,
    builder: (_) => SimpleDialog(
      children: [
        SimpleDialogOption(
          child: const Text('Camera'),
          onPressed: () {
            pickCameraImage();
            Navigator.pop(context);
          },
        ),
        const Divider(),
        SimpleDialogOption(
          child: const Text('Gallery'),
          onPressed: () {
            pickGalleryImage();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
