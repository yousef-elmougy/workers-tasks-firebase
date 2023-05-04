import '../../lib_exports.dart';

Future<void> chooseItemsDialog(
  BuildContext context, {
  required void Function(int) onPressed,
  required List<String> items,
}) async => await showDialog<void>(
    context: context,
    builder: (context) => SimpleDialog(
      children: List.generate(
        items.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (index % 1 == 0 && index != 0) const Divider(),
            SimpleDialogOption(
              onPressed: () {
                onPressed(index);
                Navigator.pop(context);
              },
              child: Text(
                items[index],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ),
  );
