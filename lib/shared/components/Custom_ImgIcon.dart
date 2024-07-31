//Mariam samy zaky

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/color_manager.dart';

class CustomImgIcon extends StatelessWidget {
  String iconPath;
  String text;
  Color color;
  double widthIcon;
  double heightIcon;


  CustomImgIcon({
    required this.iconPath,
    required this.text,
    this.color=ColorManager.colorinkBlue,
    this.widthIcon= 100,
    this.heightIcon=100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(iconPath ,width: widthIcon,height: heightIcon),
        Text(text,  style: Theme.of(context).textTheme.titleLarge,),
      ],);
  }
}
