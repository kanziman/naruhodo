import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const SimpleTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: context.color.inactive),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: context.color.background),
            ),
            filled: true,
            fillColor: context.color.hint,
            hintText: hintText,
            hintStyle:
                TextStyle(color: context.color.onHintContainer, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
