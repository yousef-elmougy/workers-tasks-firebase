import '../../../../core/functions/select_image_dialog.dart';
import '../../../../lib_exports.dart';

class ChangeImageProfileWidget extends StatelessWidget {
  const ChangeImageProfileWidget({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is UpdateImageLoading) {
            return const LoaderWidget();
          }
          final image = context.read<ProfileCubit>().file;
          return GestureDetector(
            onTap: () => _selectImage(context),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipOval(
                  child: image != null
                      ? Image.memory(
                          image,
                          fit: BoxFit.fill,
                          height: 150,
                          width: 150,
                        )
                      : CircleImageWidget(image: user.image),
                ),
                const CircleAvatar(
                  child: Icon(Icons.camera_alt_rounded),
                ),
              ],
            ),
          );
        },
      );

  Future<void> _selectImage(BuildContext context) => selectImageDialog(
        context,
        pickCameraImage: () =>
            context.read<ProfileCubit>().pickedImage(ImageSource.camera),
        pickGalleryImage: () =>
            context.read<ProfileCubit>().pickedImage(ImageSource.gallery),
      );
}
