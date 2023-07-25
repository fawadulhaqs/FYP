import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_fyp_impas/Controller/Login_Signup/Root.dart';
import 'package:project_fyp_impas/Controller/Login_Signup/binding.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.brown
  ));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      title: 'Time Analysis',
      theme: ThemeData(
          fontFamily: 'OfficialBook',
          primarySwatch: Colors.brown,
          primaryColor: Colors.brown),
      home: Root(),
    );
  }
}
