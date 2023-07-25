


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Views/Home/Dashboard.dart';
import '../../Views/Login.dart';
import 'auth_controller.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      // initState: (_){
      //   Get.put<UserController>(UserController());
      // },
      builder: (_){
        if(Get.find<AuthController>().user != null){
          return Dashboard();
        }else
          return LoginScreen();
      },
    );

  }
}