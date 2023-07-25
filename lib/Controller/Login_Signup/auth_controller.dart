import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> _firbaseUser = Rxn<User>();

  String? get user => _firbaseUser.value?.email;
  @override
  void onInit() {
    _firbaseUser.bindStream(auth.authStateChanges());
  }
}
