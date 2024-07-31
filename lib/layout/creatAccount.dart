import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1_intern2grow/layout/profileScreen.dart';
import 'package:unique_names_generator/unique_names_generator.dart';
import '../shared/components/Custom_ElevatedButton.dart';
import '../shared/components/Custom_ImgIcon.dart';
import '../shared/components/custom_textField.dart';
import '../shared/style/strings_manager.dart';
import 'LogInScreen.dart';

const List<String> listGender = <String>['Male', 'Female'];

class CreatAccountScreen extends StatefulWidget {
  static const String rountName = 'Creat';

  @override
  State<CreatAccountScreen> createState() => _CreatAccountScreenState();
}

class _CreatAccountScreenState extends State<CreatAccountScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Positioned(
                        top: AppBar().preferredSize.height + 90,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomImgIcon(
                          iconPath: 'assets/images/Rectangle 1136.png',
                          text: 'Log in to your account',
                        ),
                      ),

                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Enter your Name',
                        validator: (text) {
                          if (text?.isEmpty ?? false) {
                            return "Please Enter Your Name ";
                          }
                          return null;
                        },
                        labelText: StringsManager.UserName,
                      ), //name

                      SizedBox(height: 20),

                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Enter your email address',
                        validator: (text) {
                          if (text?.isEmpty ?? false) {
                            return "Please Enter Your Name ";
                          }
                          return null;
                        },
                        labelText: StringsManager.email,
                      ), //Email
                      SizedBox(height: 20),

                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter your password',
                        validator: (text) {
                          if (text?.isEmpty ?? false) {
                            return "Please Enter Your Passowerd ";
                          }
                          return null;
                        },
                        labelText: StringsManager.passwordHint,
                      ), //password
                      SizedBox(height: 20),

                      Text(StringsManager.Gender),
                      DropdownMenu<String>(
                        menuHeight: 200.h,
                        width: 330.w,
                        hintText: 'Select Gender',
                        onSelected: (String? value) {
                          setState(() {
                            var dropdownValueGender = value!;
                          });
                        },
                        dropdownMenuEntries: listGender
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ), //Gender
                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue!;
                              });
                              if (isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checkbox is checked!'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checkbox is unchecked!'),
                                  ),
                                );
                              }
                            },
                          ),
                          const Text('remmber me'),
                          const Spacer(),
                          const InkWell(
                            child: Text('Forgot password?'),
                          )
                        ],
                      ),
                      CustomElevatedButton(
                        text: 'Sign in',
                        onPressed: () {
                          creatSuccess();
                        },
                      ), //login

                      InkWell(
                          onTap: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account ',
                              style: TextStyle(fontSize: 18.spMin),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'login',
                                    style: TextStyle(
                                      fontSize: 18.spMax,
                                      decoration: TextDecoration.underline,
                                    )),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }

  void generateUniqueNames() {
    UniqueNamesGenerator generator =
        UniqueNamesGenerator(config: Config(dictionaries: []));
    String uniqueName = generator.generate();
    print(uniqueName);
  }

  void creatSuccess() {
    if (formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
    ;
  }
}
