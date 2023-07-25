import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Future PassReset()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email.text.trim());
      Get.snackbar('Email Sent', 'Check your spam folder to reset your password');
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('E-mail',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.brown),)
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextFormField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Enter your email',
                                        icon: Icon(Icons.email_outlined)
                                    ),
                                    validator: (value)=> value !=value!.isEmail? 'Please enter Valid Email': null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      color: Colors.brown,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextButton(
                          onPressed: PassReset,
                          child: Text('Send Recovery Email',style: TextStyle(color: Colors.white),)
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
