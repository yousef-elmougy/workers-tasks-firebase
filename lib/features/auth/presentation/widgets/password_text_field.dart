import '../../../../lib_exports.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, this.onSaved});

  final void Function(String?)? onSaved;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) => GlassMorphismWidget(
        child: TextFormFieldWidget(
          validator: (value) =>
              validInput(value!, 6, 20, ValidationType.password),
          hintText: 'Password',
          border: InputBorder.none,
          onSaved: widget.onSaved,
          obscureText: !isVisible,
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: IconButton(
            onPressed: () => setState(() => isVisible = !isVisible),
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      );
}
