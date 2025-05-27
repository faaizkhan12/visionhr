import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visionhr/utils/colors.dart';
import 'package:visionhr/view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isIOS
      ? await Firebase.initializeApp()
      : await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCadQPu2EROedXETboYJ50ND80SNhmNrkA",
      appId: "1:535069151894:android:9080256dfdf23c9e4ce8b7",
      messagingSenderId: "535069151894",
      projectId: "visionhr-e0816",
      storageBucket: "visionhr-e0816.firebasestorage.app",
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.bgcolr,
            useMaterial3: true,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}