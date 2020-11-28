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
    this.suffixIcon,
    this.withShadows = false,
    this.textAlign = TextAlign.start,
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
  final IconData suffixIcon;
  final bool withShadows;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          if (withShadows)
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 4),
            ),
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextField(
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w900,
        ),
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          errorText: errorText,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.black, size: 32)
              : null,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.black,
                )
              : null,
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
      ),
    );
  }
}
