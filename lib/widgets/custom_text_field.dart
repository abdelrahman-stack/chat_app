import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.text,
    this.onChanged,
    this.obscureText = false,
  });
  final String? text;
  Function(String)? onChanged;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      cursorColor: Colors.blueAccent,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
