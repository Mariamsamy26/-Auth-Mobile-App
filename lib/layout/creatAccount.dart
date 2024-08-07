import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:task1_intern2grow/layout/profileScreen.dart';
import 'package:unique_names_generator/unique_names_generator.dart';
import '../Providers/my_provider.dart';
import '../shared/components/Custom_ElevatedButton.dart';
import '../shared/components/Custom_ImgIcon.dart';
import '../shared/components/custom_textField.dart';
import '../shared/style/strings_manager.dart';
import 'LogInScreen.dart';
import '../shared/remote/network/firebase_function.dart';

const List<String> listGender = <String>['Male', 'Female'];

class CreatAccountScreen extends StatefulWidget {
  static const String rountName = 'Creat';

  @override
  State<CreatAccountScreen> createState() => _CreatAccountScreenState();
}

class _CreatAccountScreenState extends State<CreatAccountScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var dropdownValueGender;

  bool isLoding = false;

  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Stack(
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
                        CustomImgIcon(
                          iconPath: 'assets/images/Rectangle 1136.png',
                          text: 'Log in to your account',
                        ),

                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Enter your name',
                          validator: (text) {
                            if (text?.isEmpty ?? false) {
                              return "Please Enter Your Name ";
                            }
                            return null;
                          },
                          labelText: StringsManager.UserName,
                          titleController: nameController,
                        ), //name
                        SizedBox(height: 20),

                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Enter your email address',
                          validator: (text) {
                            if (text?.isEmpty ?? false) {
                              return "Please Enter Your email ";
                            }
                            return null;
                          },
                          labelText: StringsManager.email,
                          titleController: emailController,
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
                          titleController: passwordController,
                        ), //password
                        SizedBox(height: 20),
      
                        Text(StringsManager.Gender),
                        DropdownMenu<String>(
                          menuHeight: 200.h,
                          width: 330.w,
                          hintText: 'Select Gender',
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValueGender = value!;
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
                          text: 'Creat Account',
                          onPressed: () {
                            //isLoding = true;
                            setState(() {});
                            if (formKey.currentState!.validate()) {
                              firebaseFunctions.CreatUser(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  dropdownValueGender, () {
                                pro.initUser();
                                Navigator.pushNamedAndRemoveUntil(context,
                                    ProfileScreen.rountName, (route) => false);
                                isLoding = false;
                                setState(() {});
                              }, (errormassage) {
                                showSnackBar(context, errormassage);
                                isLoding = false;
                                setState(() {});
                              });
                            }
                            isLoding = false;
                          },
                        ), //Sign in
      
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
      ),
    );
  }

  // void generateUniqueNames() {
  //   UniqueNamesGenerator generator =
  //       UniqueNamesGenerator(config: Config(dictionaries: []));
  //   String uniqueName = generator.generate();
  //   print(uniqueName);
  // }

  void creatSuccess() {
    if (formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
    ;
  }

  void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }
}
