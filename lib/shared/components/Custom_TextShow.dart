import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextShow extends StatelessWidget {
  final bool obscureText;
  final String labelText;
  final String initialValue;
  final bool enabled;

  CustomTextShow({
    Key? key,
    this.obscureText = false,
    required this.labelText,
    required this.initialValue,
    this.enabled = false,
  })  ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText) ,
        TextFormField(
          obscureText: obscureText,
          initialValue: initialValue,
          style: TextStyle(
            color: enabled ? Colors.black : Colors.black,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color.fromRGBO(239, 239, 239, 1),
              ),
            ),
          ),
          enabled: enabled,
        ),
      ],
    );
  }
}