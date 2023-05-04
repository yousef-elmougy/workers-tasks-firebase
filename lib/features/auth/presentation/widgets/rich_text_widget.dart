import '../../../../lib_exports.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.onClicked,
    required this.text,
    required this.clickedText,
  });

  final VoidCallback? onClicked;
  final String text;
  final String clickedText;

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: text),
            TextSpan(
              text: clickedText,
              recognizer: TapGestureRecognizer()..onTap = onClicked,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
}
