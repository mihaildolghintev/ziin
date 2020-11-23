import 'package:flutter/material.dart';

class ZTextField extends StatelessWidget {
  ZTextField({
    this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
  });
  final TextEditingController controller;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;
  final String hintText;
  final String errorText;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w400,
      ),
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
