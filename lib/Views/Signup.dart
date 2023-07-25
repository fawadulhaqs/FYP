// import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/Login_Signup/SignupController.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children:  [
              const SizedBox(height: 50),
              const Text('Hello',style: const TextStyle(fontSize:32,fontWeight: FontWeight.bold,color: const Color(0xff343434)),),
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text('Enter Your Details Below',style: TextStyle(fontSize:14,color: const Color(0xff343434))),
              ),
              SizedBox(height: 50,),
              Form(
                  key: SignUpScreen._globalKey,
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
                                    child: Text('Company Name*',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff343434)),)
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
                                    keyboardType: TextInputType.name,
                                    controller: signupController.usercontroller,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Your User Name',
                                        icon: Icon(Icons.people_alt_outlined)
                                    ),
                                    validator: (value)=> value==null? 'Please enter username': null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
                                    child: Text('E-mail',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff343434)),)
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: signupController.emailcontroller,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Email*',
                                        icon: Icon(Icons.email_outlined)
                                    ),
                                    validator: (value)=> value==null? 'Please enter Email': null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
                                    child: Text('Country*',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff343434)),)
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
                                    focusNode:
                                    AlwaysDisabledFocusNode(),
                                    controller: signupController
                                        .countryController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                        icon:
                                        Icon(CupertinoIcons.flag),
                                        labelText: 'Country*',
                                        labelStyle:
                                        TextStyle(fontSize: 18)),
                                    validator: (String? value) =>
                                    value == null
                                        ? 'Please select country'
                                        : null,
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode:
                                        true, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          print(
                                              'Select country: ${country.displayName}');
                                          signupController
                                              .countryController
                                              .text = country.name;
                                          signupController
                                              .phoneCodeController
                                              .text =
                                          '+${country.phoneCode}';
                                        },
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Contact Number',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff343434)),)
                                ),
                              ),
                              Container(
                                height: 65,
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          child: Icon(Icons.phone_outlined,color: Colors.grey,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0),
                                          child: Container(
                                            width: 30,
                                            child: Text('${signupController.phoneCodeController.text}'),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Container(
                                              child: TextFormField(
                                                keyboardType: TextInputType.phone,
                                                controller: signupController.phonecontroller,
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Phone Number*',
                                                ),
                                                validator: (value)=> value==null? 'Please enter Email': null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
                                    child: Text('Password',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff343434)),)
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
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: signupController.passcontroller,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Your Password',
                                        icon: Icon(Icons.lock_outline)
                                    ),
                                    validator: (value)=> value==null? 'Enter your Password': null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
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
                          onPressed: (){
                            signupController.onSignUp(SignUpScreen._globalKey);
                          },
                          child: Text('Sign Up',style: TextStyle(color: Colors.white),)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account'),
                    TextButton(
                        onPressed: (){
                          Get.back();
                        },
                        child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),



      // Center(
      //   child: SingleChildScrollView(
      //       child: Card(
      //     elevation: 15,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //     ),
      //     child: Container(
      //       width: MediaQuery.of(context).size.width - 90,
      //       height: MediaQuery.of(context).size.height/1.5,
      //       child: Row(
      //         children: [
      //           Flexible(
      //               child: Stack(children: [
      //             Material(
      //               elevation: 10,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(20.0),
      //               ),
      //               child: Container(
      //                 width: MediaQuery.of(context).size.width / 2,
      //                 height: MediaQuery.of(context).size.height,
      //                 child: SvgPicture.asset(
      //                   'assets/images/Signup.svg',
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //                 Column(
      //                   // crossAxisAlignment: CrossAxisAlignment.start,
      //                   // mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Container(
      //                       // width: MediaQuery.of(context).size.width/4,
      //                         height: MediaQuery.of(context).size.height/3,
      //                         child: SvgPicture.asset('assets/images/2009 (1).svg')
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 20),
      //                       child: Text(
      //                         'Hello There !!',
      //                         textAlign: TextAlign.start,
      //                         style: TextStyle(color: Color(0xFF3C2115),fontWeight: FontWeight.bold,fontSize: 40),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 30,
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 50),
      //                       child: Text(
      //                         'Register Your Account',
      //                         textAlign: TextAlign.start,
      //                         style: TextStyle(color: Color(0xFF3C2115),fontWeight: FontWeight.bold,fontSize: 30),
      //                       ),
      //                     ),
      //                   ],
      //                 )
      //           ])),
      //           Flexible(
      //             child: SingleChildScrollView(
      //               child: Container(
      //                 height: MediaQuery.of(context).size.height * 1.8,
      //                 child: Column(
      //                   // mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Form(
      //                       key: _globalKey,
      //                       child: Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 12.0),
      //                         child: Center(
      //                           child: Column(
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               SizedBox(height: 10,),
      //                               Card(
      //                                 elevation: 3,
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       bottom: 8.0,
      //                                       left: 6.0,
      //                                       right: 6.0),
      //                                   child: TextFormField(
      //                                     keyboardType: TextInputType.name,
      //                                     controller: signupController
      //                                         .usercontroller,
      //                                     decoration: const InputDecoration(
      //                                         icon: Icon(CupertinoIcons
      //                                             .person_alt_circle),
      //                                         hintText: '',
      //                                         labelText: 'Company Name*',
      //                                         labelStyle:
      //                                             TextStyle(fontSize: 18)),
      //                                     validator: (String? value) {
      //                                       return signupController
      //                                           .validateUsername(value!);
      //                                     },
      //                                   ),
      //                                 ),
      //                               ),
      //                               Card(
      //                                 elevation: 3,
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       bottom: 8.0,
      //                                       left: 6.0,
      //                                       right: 6.0),
      //                                   child: TextFormField(
      //                                     keyboardType:
      //                                         TextInputType.emailAddress,
      //                                     controller: signupController
      //                                         .emailcontroller,
      //                                     decoration: const InputDecoration(
      //                                         icon:
      //                                             Icon(CupertinoIcons.mail),
      //                                         hintText:
      //                                             'abc@your-domain.com',
      //                                         labelText: 'Email*',
      //                                         labelStyle:
      //                                             TextStyle(fontSize: 18)),
      //                                     validator: (String? value) {
      //                                       return signupController
      //                                           .validateEmail(value!);
      //                                     },
      //                                   ),
      //                                 ),
      //                               ),
      //                               SizedBox(
      //                                 height: 15,
      //                               ),
      //                               Card(
      //                                 elevation: 3,
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       bottom: 8.0,
      //                                       left: 6.0,
      //                                       right: 6.0),
      //                                   child: TextFormField(
      //                                     focusNode:
      //                                         AlwaysDisabledFocusNode(),
      //                                     keyboardType:
      //                                         TextInputType.emailAddress,
      //                                     controller: signupController
      //                                         .countryController,
      //                                     decoration: const InputDecoration(
      //                                         icon:
      //                                             Icon(CupertinoIcons.flag),
      //                                         labelText: 'Country*',
      //                                         labelStyle:
      //                                             TextStyle(fontSize: 18)),
      //                                     validator: (String? value) =>
      //                                         value == null
      //                                             ? 'Please select country'
      //                                             : null,
      //                                     onTap: () {
      //                                       showCountryPicker(
      //                                         context: context,
      //                                         showPhoneCode:
      //                                             true, // optional. Shows phone code before the country name.
      //                                         onSelect: (Country country) {
      //                                           print(
      //                                               'Select country: ${country.displayName}');
      //                                           signupController
      //                                               .countryController
      //                                               .text = country.name;
      //                                           signupController
      //                                                   .phoneCodeController
      //                                                   .text =
      //                                               '+${country.phoneCode}';
      //                                         },
      //                                       );
      //                                     },
      //                                   ),
      //                                 ),
      //                               ),
      //                               SizedBox(
      //                                 height: 15,
      //                               ),
      //                               Card(
      //                                 elevation: 3,
      //                                 child: Row(
      //                                   children: [
      //                                     Flexible(
      //                                       child: Container(
      //                                         width: 90,
      //                                         child: Padding(
      //                                           padding:
      //                                               const EdgeInsets.only(
      //                                                   bottom: 8.0,
      //                                                   left: 6.0,
      //                                                   right: 6.0),
      //                                           child: TextFormField(
      //                                             keyboardType:
      //                                                 TextInputType.phone,
      //                                             focusNode:
      //                                                 AlwaysDisabledFocusNode(),
      //                                             controller: signupController
      //                                                 .phoneCodeController,
      //                                             decoration:
      //                                                 const InputDecoration(
      //                                                     icon: Icon(
      //                                                         CupertinoIcons
      //                                                             .phone_fill),
      //                                                     hintText: '',
      //                                                     labelText: '+00',
      //                                                     labelStyle:
      //                                                         TextStyle(
      //                                                             fontSize:
      //                                                                 18)),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     Flexible(
      //                                       child: Container(
      //                                         // width: MediaQuery.of(context)
      //                                         //         .size
      //                                         //         .width /
      //                                         //     1.35,
      //                                         child: Padding(
      //                                           padding:
      //                                               const EdgeInsets.only(
      //                                                   bottom: 8.0,
      //                                                   left: 6.0,
      //                                                   right: 6.0),
      //                                           child: TextFormField(
      //                                             keyboardType:
      //                                                 TextInputType.phone,
      //                                             controller:
      //                                                 signupController
      //                                                     .phonecontroller,
      //                                             maxLength: 10,
      //                                             decoration:
      //                                                 const InputDecoration(
      //                                                     // icon: Icon(CupertinoIcons.phone_fill,color: Colors.transparent,),
      //                                                     hintText: '',
      //                                                     labelText:
      //                                                         'Phone No*',
      //                                                     labelStyle:
      //                                                         TextStyle(
      //                                                             fontSize:
      //                                                                 18)),
      //                                             validator:
      //                                                 (String? value) {
      //                                               return signupController
      //                                                   .validatePhone(
      //                                                       value!);
      //                                             },
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               SizedBox(
      //                                 height: 15,
      //                               ),
      //                               Card(
      //                                 elevation: 3,
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       bottom: 8.0,
      //                                       left: 6.0,
      //                                       right: 6.0),
      //                                   child: TextFormField(
      //                                     obscureText: true,
      //                                     controller: signupController
      //                                         .passcontroller,
      //                                     decoration: const InputDecoration(
      //                                         icon: Icon(
      //                                             CupertinoIcons.padlock),
      //                                         hintText: 'Password',
      //                                         labelText: 'Password*',
      //                                         labelStyle:
      //                                             TextStyle(fontSize: 18)),
      //                                     validator: (String? value) {
      //                                       return signupController
      //                                           .validatePassword(value!);
      //                                     },
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       children: [
      //                         Text('Already have an Account?'),
      //                         MaterialButton(
      //                           onPressed: () {
      //                             Get.back();
      //                           },
      //                           child: Text(
      //                             'Login',
      //                             style: TextStyle(color: Colors.brown),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 15,
      //                     ),
      //                     Container(
      //                         width: 200,
      //                         height: 45,
      //                         decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(20)),
      //                         child: ElevatedButton(
      //                             child: Text("Register".toUpperCase(),
      //                                 style: TextStyle(fontSize: 14)),
      //                             style: ButtonStyle(
      //                                 foregroundColor:
      //                                     MaterialStateProperty.all<Color>(
      //                                         Colors.white),
      //                                 backgroundColor:
      //                                     MaterialStateProperty.all<Color>(
      //                                         Colors.brown),
      //                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                                     RoundedRectangleBorder(
      //                                         borderRadius:
      //                                             BorderRadius.circular(30),
      //                                         side: BorderSide(
      //                                             color: Colors.white,
      //                                             width: 2)))),
      //                             onPressed: () {
      //                               signupController.onSignUp(_globalKey);
      //                             }))
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   )),
      // ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
