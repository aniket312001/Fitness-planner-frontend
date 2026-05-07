import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  final bool obscureText;

  final TextInputType keyboardType;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  final void Function(String)? onChanged;

  final void Function(String)? onSubmitted;

  final int maxLines;

  final bool enabled;

  final TextInputAction? textInputAction;

  final Iterable<String>? autofillHints;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.enabled = true,
    this.textInputAction,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      maxLines: maxLines,
      enabled: enabled,
      textInputAction: textInputAction,

      autofillHints: autofillHints,

      enableSuggestions: true,

      autocorrect: false,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: prefixIcon,

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
