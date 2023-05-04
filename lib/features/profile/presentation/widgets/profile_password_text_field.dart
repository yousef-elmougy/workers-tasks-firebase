import '../../../../lib_exports.dart';

class ProfilePasswordTextField extends StatefulWidget {
  const ProfilePasswordTextField({
    super.key,
    required this.onChanged,
    this.hintText = 'Password',
  });

  final ValueChanged onChanged;
  final String hintText;

  @override
  State<ProfilePasswordTextField> createState() =>
      _ProfilePasswordTextFieldState();
}

class _ProfilePasswordTextFieldState extends State<ProfilePasswordTextField> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) => TextFormFieldWidget(
        hintText: widget.hintText,
        validator: (value) =>
            validInput(value!, 6, 20, ValidationType.password),
        obscureText: !visibility,
        prefixIcon: const Icon(Icons.lock_rounded),
        suffixIcon: IconButton(
          onPressed: () => setState(() => visibility = !visibility),
          icon: Icon(
            visibility ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        onChanged: widget.onChanged,
      );
}
