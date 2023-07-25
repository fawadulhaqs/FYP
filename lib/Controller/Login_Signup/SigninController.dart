
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Views/Home/Dashboard.dart';


class SignInController extends GetxController {
  TextEditingController emailSignIn = TextEditingController();
  TextEditingController passwordSignIn = TextEditingController();
  final auth = FirebaseAuth.instance;
  // final firstore = FirebaseFirestore.instance;

  String? validateUserName(String value) {
    if (!value.isEmail) {
      return 'Enter valid email';
    } else if (value == null) {
      return "Email cant't be Empty";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length < 4) {
      return 'Password must be greater then 4';
    } else if (value == null) {
      return "Email cant't be Empty";
    } else {
      return null;
    }
  }
  void signOut() async{
    try{auth.signOut();}
    catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void onLoginIn(_formkey) {
    final isvalid = _formkey.currentState.validate();
    if (!isvalid) {
      return;
    } else {
      login(emailSignIn.text, passwordSignIn.text);
    }
    _formkey.currentState.save;
  }

  login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.to(Dashboard());

      Get.snackbar('Success', 'Login Success Fully');
    } catch (e) {
      print(e);
      Get.snackbar('Erorr', e.toString());
    }
  }
}
