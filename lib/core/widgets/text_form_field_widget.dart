import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.maxLine = 1,
    this.hintText,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.controller,
    this.border,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.validator,
    this.maxLength,
    this.textInputAction = TextInputAction.next, this.hintStyle,
  });

  final int maxLine;
  final int? maxLength;
  final String? hintText;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final InputBorder? border;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) => TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        autofocus: autofocus,
        readOnly: readOnly,
        initialValue: initialValue,
        obscureText: obscureText,
        enabled: enabled,
        onTap: onTap,
        validator: validator ??
            (value) => value?.isEmpty ?? false || value == null
                ? 'Field is Required'
                : null,
        onSaved: onSaved,
        onChanged: onChanged,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: border ?? buildBorder(),
          errorBorder: border ?? buildBorder(Colors.red),
          focusedBorder: border ?? buildBorder(kPrimaryColor),
          border: border ?? buildBorder(),
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: Colors.white,
          prefixIconColor: Colors.white,
        ),
        maxLines: maxLine,
        maxLength: maxLength,
      );

  OutlineInputBorder buildBorder([Color? color]) => OutlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.white),
        borderRadius: BorderRadius.circular(15),
      );
}
