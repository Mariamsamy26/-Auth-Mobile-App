import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String text;
  final void Function()? onPressed;
  bool isChecked;

  CustomCheckbox({
    required this.text,
    required this.onPressed,
    this.isChecked = false,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              widget.isChecked = newValue!;
            });
            if (widget.isChecked) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('your data will save'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('your data will not save!'),
                ),
              );
            }
          },
        ),
        Text(widget.text),
        const Spacer(),
        InkWell(
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: widget.onPressed, // Use the provided callback
        ),
      ],
    );
  }
}
