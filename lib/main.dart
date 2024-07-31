import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'layout/LogInScreen.dart';
import 'layout/creatAccount.dart';
import 'layout/profileScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:  LogInScreen.routeName,
          routes: {
            LogInScreen.routeName: (c) => LogInScreen(),
            CreatAccountScreen.rountName: (C) => CreatAccountScreen(),
            ProfileScreen.rountName: (C) => ProfileScreen(),
          },
        );
      },
    );
  }
}