import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final bool obscureText;
  final String labelText;

  CustomTextField({
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.validator,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText) ,
        TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color.fromRGBO(239, 239, 239, 1),
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
