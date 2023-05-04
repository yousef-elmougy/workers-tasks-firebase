import '../../lib_exports.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) => Center(
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: image,
            errorWidget: (_, __, ___) =>
                const Icon(Icons.error, color: Colors.red, size: 50),
            fit: BoxFit.fill,
            height: 150,
            width: 150,
          ),
        ),
      );
}
