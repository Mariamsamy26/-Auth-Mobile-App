import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Providers/my_provider.dart';
import 'firebase_options.dart';
import 'layout/LogInScreen.dart';
import 'layout/creatAccount.dart';
import 'layout/profileScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MyProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:
          provider.firebaseUser != null
              ? ProfileScreen.rountName
              : CreatAccountScreen.rountName,
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
