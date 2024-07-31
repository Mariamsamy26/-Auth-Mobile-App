import 'package:flutter/material.dart';

import '../style/color_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double width;
  final double height;
  final Color colorBorder;
  final Color colorButton;
  final Color colorText;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.height = 62,
    this.width = 327,
    this.colorBorder = ColorManager.colorWhit,
    this.colorButton = ColorManager.colorinkBlue,
    this.colorText = ColorManager.colorWhit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorButton,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 4,
                color: colorBorder,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              fontFamily: 'Gemunu Libre',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
