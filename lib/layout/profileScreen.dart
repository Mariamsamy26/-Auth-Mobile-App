import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1_intern2grow/layout/LogInScreen.dart';
import '../shared/components/Custom_ElevatedButton.dart';
import '../shared/components/Custom_ImgIcon.dart';
import '../shared/components/Custom_TextShow.dart';
import '../shared/style/color_manager.dart';

class ProfileScreen extends StatefulWidget {
  static const String rountName ='profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _profileScreeenState();

}

class _profileScreeenState extends State<ProfileScreen> {
  get formKey => null;

  @override

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
        ),
        Image.asset(
          "assets/images/Frame 645.png",
          width: double.infinity,
          height: 180.h,
          fit: BoxFit.cover,
        ),
        // Third widget in the stack: Scaffold for content
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 160),
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  0.h,
                  20.w,
                  25.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [Positioned(
                    top: AppBar().preferredSize.height + 90,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomImgIcon(
                      iconPath: 'assets/images/Rectangle 1136.png',
                      text: '6463463416416',),
                  ),
                    CustomTextShow(
                      labelText: 'Username',
                      initialValue: 'mariam',
                    ),//name
                    const SizedBox(height: 20),

                    CustomTextShow(
                      labelText: 'Email Address',
                      initialValue: 'emailData',
                    ),//email
                    const SizedBox(height: 20),

                    CustomTextShow(
                      labelText: 'generat',
                      initialValue: 'emailData',
                    ),//generat
                    const SizedBox(height: 20),

                    CustomElevatedButton(
                      colorButton: ColorManager.colorRed,
                      text: 'log out',
                      onPressed: () {
                        Navigator.popAndPushNamed(context, LogInScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}