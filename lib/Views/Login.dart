import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Views/ForgotPass.dart';

import '../Controller/Login_Signup/SigninController.dart';
import 'Signup.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final signinController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const SizedBox(height: 50),
              const Text('Hello',style: const TextStyle(fontSize:32,fontWeight: FontWeight.bold,color: Colors.brown),),
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text('Enter Your Details Below',style: TextStyle(fontSize:14,color: Colors.brown)),
              ),
              SizedBox(height: 50,),
              Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: signinController.emailSignIn,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Enter your email',
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
                                    child: Text('Password',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.brown),)
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
                                    controller: signinController.passwordSignIn,
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
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: ()async{
                        Get.to(ForgotPassword(),transition: Transition.rightToLeft);
                      },
                      child: Text('Forgot Password?',style: TextStyle(color: Colors.brown),)
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
                          onPressed: (){
                            signinController.onLoginIn(_globalKey);
                          },
                          child: Text('Sign In',style: TextStyle(color: Colors.white),)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have An Account"),
                    TextButton(
                        onPressed: (){
                          Get.to(SignUpScreen(),transition: Transition.rightToLeft);
                        },
                        child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),)
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
      //     child: Card(
      //       elevation: 15,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(20.0),
      //       ),
      //       child: Container(
      //         width: MediaQuery.of(context).size.width - 90,
      //         height: MediaQuery.of(context).size.height / 1.5,
      //         child: Row(
      //           children: [
      //             Flexible(
      //                 child: Stack(
      //                     // alignment: AlignmentDirectional.topStart,
      //                     children: [
      //                   Material(
      //                     elevation: 10,
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20.0),
      //                     ),
      //                     child: Container(
      //                       width: MediaQuery.of(context).size.width / 2,
      //                       height: MediaQuery.of(context).size.height,
      //                       child: SvgPicture.asset(
      //                         'assets/images/Signup.svg',
      //                         fit: BoxFit.cover,
      //                       ),
      //                     ),
      //                   ),
      //                   Column(
      //                     // crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Container(
      //                           height: MediaQuery.of(context).size.height / 3,
      //                           child: SvgPicture.asset(
      //                             'assets/images/2009 (1).svg',
      //                           )),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 20),
      //                         child: Text(
      //                           'Welcome',
      //                           textAlign: TextAlign.start,
      //                           style: TextStyle(
      //                               color: Color(0xFF3C2115),
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 40),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 30,
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 70),
      //                         child: Text(
      //                           'Login to your account',
      //                           textAlign: TextAlign.center,
      //                           style: TextStyle(
      //                               color: Color(0xFF3C2115),
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 35),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //                 ])),
      //             Flexible(
      //               child: SingleChildScrollView(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Form(
      //                       key: _globalKey,
      //                       child: Padding(
      //                         padding:
      //                             const EdgeInsets.symmetric(horizontal: 12.0),
      //                         child: Column(
      //                           // mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Card(
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(10.0),
      //                               ),
      //                               elevation: 3,
      //                               child: Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     bottom: 8.0, left: 6.0, right: 6.0),
      //                                 child: TextFormField(
      //                                   keyboardType:
      //                                       TextInputType.emailAddress,
      //                                   controller:
      //                                       signinController.emailSignIn,
      //                                   decoration: const InputDecoration(
      //                                       icon: Icon(CupertinoIcons
      //                                           .person_alt_circle),
      //                                       hintText:
      //                                           'abc@your-company-domain.com',
      //                                       labelText: 'Email*',
      //                                       labelStyle:
      //                                           TextStyle(fontSize: 18)),
      //                                   validator: (String? value) {
      //                                     return signinController
      //                                         .validateUserName(value!);
      //                                   },
      //                                 ),
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: 15,
      //                             ),
      //                             Card(
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(10.0),
      //                               ),
      //                               elevation: 3,
      //                               child: Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     bottom: 8.0, left: 6.0, right: 6.0),
      //                                 child: TextFormField(
      //                                   controller:
      //                                       signinController.passwordSignIn,
      //                                   decoration: const InputDecoration(
      //                                       icon: Icon(CupertinoIcons.padlock),
      //                                       hintText: 'Password',
      //                                       labelText: 'Password*',
      //                                       labelStyle:
      //                                           TextStyle(fontSize: 18)),
      //                                   validator: (String? value) {
      //                                     return signinController
      //                                         .validatePassword(value!);
      //                                   },
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       children: [
      //                         Text(
      //                           'Create new Account!',
      //                           softWrap: true,
      //                         ),
      //                         MaterialButton(
      //                           onPressed: () {
      //                             Get.to(SignUpScreen(),
      //                                 transition: Transition.noTransition);
      //                           },
      //                           child: Text(
      //                             'Register ?',
      //                             softWrap: true,
      //                             style: TextStyle(
      //                                 color: Colors.brown,
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     Container(
      //                         width: 200,
      //                         height: 45,
      //                         decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(20)),
      //                         child: ElevatedButton(
      //                             child: Text("Login".toUpperCase(),
      //                                 style: TextStyle(fontSize: 14)),
      //                             style: ButtonStyle(
      //                                 foregroundColor:
      //                                     MaterialStateProperty.all<Color>(
      //                                         Colors.white),
      //                                 backgroundColor:
      //                                     MaterialStateProperty.all<Color>(
      //                                         Colors.brown),
      //                                 shape: MaterialStateProperty.all<
      //                                         RoundedRectangleBorder>(
      //                                     RoundedRectangleBorder(
      //                                         borderRadius:
      //                                             BorderRadius.circular(30),
      //                                         side: BorderSide(
      //                                             color: Colors.white,
      //                                             width: 2)))),
      //                             onPressed: () {
      //                               signinController.onLoginIn(_globalKey);
      //                             }))
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}