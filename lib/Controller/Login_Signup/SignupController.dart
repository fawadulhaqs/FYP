import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();
  TextEditingController usercontroller = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String? validateEmail(String value) {
    if (!value.isEmail) {
      return 'Enter valid email';
    } else if (value == null) {
      return "Email cant't be Empty";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value == null) {
      return "Email cant't be Empty";
    } else if (value.length < 4) {
      return "Password must be greater then 4";
    } else {
      return null;
    }
  }

  String? validateUsername(String value) {
    if (value == null) {
      return "UserName cant't be Empty";
    } else if (value.length < 4) {
      return "UserName must be greater then 4";
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (value.length < 10) {
      return 'Invalid Phone Number';
    } else if (value == null) {
      return "Please enter a phone number";
    } else {
      return null;
    }
  }

  void onSignUp(_formkey) {
    final isvalid = _formkey.currentState.validate();
    // if (userImage == null) {
    //   Get.snackbar('Error', 'We could found the image');
    //   return;
    // }
    if (!isvalid) {
      Get.snackbar('Error', 'Form is incomplete');
      return;
    } else {
      signUp(emailcontroller.text, passcontroller.text, usercontroller.text,
          phonecontroller.text);
      // Get.back();
    }
    _formkey.currentState.save;
  }

  signUp(String email, String password, String name, String phoneNo) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestore.collection('Companies').doc(auth.currentUser?.uid).set({
        'company_id': auth.currentUser?.uid,
        'name': name,
        'email': email,
        'phone': phoneNo,
        'password': password
      }).then((value) => print('Successsssssssssssss'));

      Get.back();
      Get.snackbar('Success', 'Account created Successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
