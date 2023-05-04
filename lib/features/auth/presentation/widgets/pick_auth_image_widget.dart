import '../../../../core/functions/select_image_dialog.dart';
import '../../../../lib_exports.dart';

class PickAuthImageWidget extends StatelessWidget {
  const PickAuthImageWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is PickImageLoading) {
            return const LoaderWidget();
          } else {
            final image = context.read<AuthCubit>().file;
            return GestureDetector(
              onTap: () => _selectImage(context),
              child: Center(
                child: GlassMorphismWidget(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: image != null
                        ? Image.memory(
                            image,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )
                        : const Icon(
                            Icons.photo_camera,
                            size: 70,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            );
          }
        },
      );

  Future<void> _selectImage(BuildContext context) => selectImageDialog(
        context,
        pickCameraImage: () =>
            context.read<AuthCubit>().pickedImage(ImageSource.camera),
        pickGalleryImage: () =>
            context.read<AuthCubit>().pickedImage(ImageSource.gallery),
      );
}
