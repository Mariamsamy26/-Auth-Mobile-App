
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1_intern2grow/Providers/my_provider.dart';
import 'package:task1_intern2grow/layout/profileScreen.dart';
import 'package:task1_intern2grow/shared/style/color_manager.dart';
import '../shared/components/Custom_ElevatedButton.dart';
import '../shared/components/Custom_ImgIcon.dart';
import '../shared/components/custom_textField.dart';
import '../shared/style/strings_manager.dart';
import 'creatAccount.dart';
import '../shared/remote/network/firebase_function.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = 'logIn';

  const LogInScreen({super.key});
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoding = false;
  bool read = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro =Provider.of<MyProvider>(context);
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
            // Make Scaffold background transparent
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
                            hintText: 'Enter your email',
                            validator: (text) {
                              if (text?.isEmpty ?? true) {
                                return "Please Enter Your email";
                              }
                              return null;
                            },
                            labelText: StringsManager.UserName,
                            titleController: emailController,
                          ),
                          SizedBox(height: 22.h),

                          Text("password") ,
                          TextFormField(
                            validator: (text) {
                              if (text?.isEmpty ?? true) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            obscureText: read
                                ? false
                                : true,
                            keyboardType: TextInputType.name,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffix: IconButton(onPressed: () {
                                setState(() {
                                  read = !read;
                                });
                                }, icon: Icon(
                                read
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              ),
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(239, 239, 239, 1),)
                                )
                            ),

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
                              isLoding = true;
                              setState(() {});
                              if (formKey.currentState!.validate()) {
                                firebaseFunctions.loginUser(
                                    emailController.text, passwordController.text,
                                        () {
                                      pro.initUser();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        ProfileScreen.rountName,
                                            (route) => false,
                                      );
                                      isLoding = false;
                                      setState(() {});
                                      if (isChecked) {
                                        _saveCredentials();
                                      } else {
                                        _clearCredentials();
                                      }
                                    }, (errormassage) {
                                  showSnackBar(context, errormassage);
                                  isLoding = false;
                                  setState(() {});
                                });
                              }
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
      ),
    );
  }

  void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }
  // Load saved credentials
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool('rememberMe') ?? false;
      if (isChecked) {
        emailController.text = prefs.getString('savedEmail') ?? '';
        passwordController.text = prefs.getString('savedPassword') ?? '';
      }
    });
  }
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', true);
    prefs.setString('savedEmail', emailController.text);
    prefs.setString('savedPassword', passwordController.text); // Not recommended for security reasons
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('rememberMe');
    prefs.remove('savedEmail');
    prefs.remove('savedPassword');
  }

}
