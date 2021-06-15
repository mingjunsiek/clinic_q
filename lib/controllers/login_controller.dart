import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = '';
  var password = '';
  var isLoggedIn = false;

  final flutterFireController = Get.put(FlutterFireController());

  void isLogin() {
    print(flutterFireController.auth.currentUser);
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await flutterFireController.auth
          .signInWithEmailAndPassword(email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
      return "An unexpected error occured";
    }
  }
}
