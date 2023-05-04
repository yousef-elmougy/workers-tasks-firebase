import '../../../../core/functions/choose_items_dialog.dart';
import '../../../../lib_exports.dart';

class PositionTextField extends StatefulWidget {
  const PositionTextField({super.key});

  @override
  State<PositionTextField> createState() => _PositionTextFieldState();
}

class _PositionTextFieldState extends State<PositionTextField> {
  @override
  Widget build(BuildContext context) {
    final position = context.read<AuthCubit>().position;
    return GlassMorphismWidget(
      child: TextFormFieldWidget(
        readOnly: true,
        hintText: position ?? 'Position in Company',
        hintStyle: TextStyle(
          color: position == null ? null : Colors.white,
        ),
        onTap: _positionsDialog,
        border: InputBorder.none,
        prefixIcon: const Icon(
          Icons.apartment_rounded,
          color: Colors.white,
        ),
        validator: (_) => position == null ? 'category is required' : null,
      ),
    );
  }

  Future<void> _positionsDialog() => chooseItemsDialog(
        context,
        onPressed: (index) => setState(
            () => context.read<AuthCubit>().position = positions[index]),
        items: positions,
      );
}
