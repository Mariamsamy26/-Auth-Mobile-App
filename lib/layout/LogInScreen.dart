import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1_intern2grow/layout/profileScreen.dart';
import 'package:task1_intern2grow/shared/style/color_manager.dart';
import '../shared/components/Custom_ElevatedButton.dart';
import '../shared/components/Custom_ImgIcon.dart';
import '../shared/components/custom_textField.dart';
import '../shared/style/strings_manager.dart';
import 'creatAccount.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = 'logIn';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;

  void login() async {
    // Add your login logic here
    // var response = await HttpHelper.loginRequest("hghg","hghjg");
    // var data = jsonDecode(response.body) as Map;
    // data.token
  }

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
          backgroundColor: Colors.transparent, // Make Scaffold background transparent
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomImgIcon(
                    iconPath: 'assets/images/Rectangle 1136.png',
                    text: StringsManager.ToLogIn,
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          hintText: 'Enter your Name',
                          validator: (text) {
                            if (text?.isEmpty ?? true) {
                              return "Please Enter Your Name";
                            }
                            return null;
                          },
                          labelText: StringsManager.UserName,
                        ),
                        SizedBox(height: 22.h),
                        CustomTextField(
                          hintText: '.........',
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text) {
                            if (text?.isEmpty ?? true) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          labelText: StringsManager.passwordHint,
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isChecked = newValue ?? false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isChecked
                                          ? 'Checkbox is checked!'
                                          : 'Checkbox is unchecked!',
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Text('Remember me'),
                            const Spacer(),
                            InkWell(
                              child: const Text('Forgot password?'),
                              onTap: () {
                                // Handle forgot password tap
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        CustomElevatedButton(
                          width: double.infinity,
                          text: 'Sign in',
                          onPressed: () {
                            loginSuccess();
                          },
                        ),
                        SizedBox(height: 18.h),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreatAccountScreen(),
                              ),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: TextStyle(fontSize: 18.sp),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.colorinkBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void loginSuccess() {
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }
}
